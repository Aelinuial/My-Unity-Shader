Shader "myShader/ZeldaToon"
{
    Properties
    {
        _MainColor ("Main Color", Color) = (1, 1, 1, 1)
        [HDR]_AmbientColor ("Ambient Color", Color) = (1, 1, 1, 1)
        _MainTex ("Texture", 2D) = "white" {}
        _ShadowRange ("Shadow Range", float) = 0.01
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

            struct appdata
            {
                float3 normal : NORMAL;
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 worldPos : TEXCOORD1;
                float3 worldNormal : TEXCOORD2;
                float4 vertex : SV_POSITION;
            };

            float4 _MainColor;
            float4 _AmbientColor;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _ShadowRange;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 worldLight = UnityWorldSpaceLightDir(i.worldPos);
                float3 lightColor = _LightColor0.rgb;
                float shadow = dot(worldLight, i.worldNormal);
                shadow = smoothstep(_ShadowRange, _ShadowRange, shadow);
                float3 shadowColor = shadow * lightColor;
                shadowColor += _AmbientColor;
                shadowColor *= _MainColor;
                fixed4 textureColor = tex2D(_MainTex, i.uv);
                fixed4 finalColor = textureColor * float4(shadowColor, 1.0f);
                return finalColor;
            }
            ENDCG
        }
    }
}
