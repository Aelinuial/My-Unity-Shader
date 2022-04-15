#ifndef FUR_INCLUDE
#define FUR_INCLUDE

#pragma target 3.0

#include "Lighting.cginc"
#include "UnityCG.cginc"

sampler2D _furTex;
sampler2D _furMaskTex;
sampler2D _noiseTex;

float4 _furTex_ST;
float4 _noiseTex_ST;

float _furLength;
float _furRadius;
float4 _uvOffset;

float _occlusionPower;
float4 _occlusionColor;

struct appdata{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
    float2 uv     : TEXCOORD0;
};

struct v2f{
    float4 vertex : SV_POSITION;
    float4 uv : TEXCOORD0;
    float3 lightMul : TEXCOORD1;
    float3 lightAdd : TEXCOORD2;
};

v2f vert(appdata v){
    v2f o;
    o.uv.xy = TRANSFORM_TEX(v.uv, _furTex);
    o.uv.zw = TRANSFORM_TEX(v.uv, _noiseTex);
    v.vertex.xyz = v.vertex.xyz + v.normal * _furLength * FURSTEP;
    o.vertex = UnityObjectToClipPos(v.vertex);

    float occlusion = saturate(pow(FURSTEP, _occlusionPower));
    float3 occlusionColor = lerp(_occlusionColor, 1, occlusion);
    o.lightMul = occlusionColor;

    return o;
}

float4 frag(v2f i) : SV_Target{
    float3 albedo = tex2D(_furTex, i.uv.xy).rgb;
    float alpha = tex2D(_noiseTex, i.uv.zw).r;
    if(FURSTEP < 0.2){ alpha = 1.0f; }
    alpha = saturate(alpha - FURSTEP * _furRadius);
    float3 finalColor = albedo * i.lightMul;
    return float4(finalColor ,alpha);
}

#endif