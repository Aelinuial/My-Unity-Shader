#ifndef FUR_INCLUDE
#define FUR_INCLUDE

#pragma target 3.0

#include "Lighting.cginc"
#include "UnityCG.cginc"

sampler2D _furTex;
sampler2D _noiseTex;
float _furLength;
float4 _uvOffset;

struct appdata{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
    float2 uv     : TEXCOORD0;
};

struct v2f{
    float4 vertex : SV_POSITION;
    float2 uv : TEXCOORD0;
};

v2f vert(appdata v){
    v2f o;
    o.uv = v.uv;
    v.vertex.xyz = v.vertex.xyz + v.normal * _furLength * FURSTEP;
    o.vertex = UnityObjectToClipPos(v.vertex);
    return o;
}

float4 frag(v2f i) : SV_Target{
    float4 color = float4(0, 0, 0, 1 - FURSTEP);
    return color;
}

#endif