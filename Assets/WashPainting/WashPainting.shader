Shader "myShader/WashPainting"
{
    Properties
    {
        [Header(OutLine)]
        _StrokeColor("Stroke Color", Color) = (0, 0, 0, 1)
        _OutlineNoise("Outline Noise Map", 2D) = "white"{}
        _OutlineWidth("Outline Width", Range(0, 1)) = 0.1
        _OutsideNoiseWidth("Outside Noise Width", Range(0, 1)) = 0.15
        _MaxOutlineOffset("Max Outline Z Offset", Range(0, 1)) = 0.5
    
        [Header(Interior)]
        _RampTexture("Ramp Texture", 2D) = "white"{}

    }
    SubShader
    {
        Tags { 
                "RenderType"="Opaque" 
                "Queue"="Geometry"
        }

        Pass
        {
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            float4 _StrokeColor;
            sampler2D _OutlineNoise;
            float _OutlineWidth;
            float _OutsideNoiseWidth;
            float _MaxOutlineOffset;

            v2f vert (appdata v)
            {
                float4 burn = tex2Dlod(_OutlineNoise, v.vertex);
                float4 vspos = mul(UNITY_MATRIX_MV, v.vertex);
                float3 vsnormal = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
                vsnormal.z = -0.5;
                vsnormal = normalize(vsnormal);
                vspos = vspos + float4(vsnormal, 0) * _OutlineWidth * burn.r;

                v2f o;
                o.vertex = mul(UNITY_MATRIX_P, vspos);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(0, 0, 0, 1);
            }
            ENDCG
        }

        //增加的一层笔触
        Pass
        {
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv :TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float4 _StrokeColor;
            sampler2D _OutlineNoise;
            float4 _OutlineNoise_ST;
            float _OutlineWidth;
            float _OutsideNoiseWidth;
            float _MaxOutlineOffset;

            v2f vert (appdata v)
            {
                float4 burn = tex2Dlod(_OutlineNoise, v.vertex);
                float4 vspos = mul(UNITY_MATRIX_MV, v.vertex);
                float3 vsnormal = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
                vsnormal.z = -0.5;
                vsnormal = normalize(vsnormal);
                vspos = vspos + float4(vsnormal, 0) * _OutsideNoiseWidth * burn.r;

                v2f o;
                o.vertex = mul(UNITY_MATRIX_P, vspos);
                o.uv = TRANSFORM_TEX(v.uv, _OutlineNoise);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 burn = tex2D(_OutlineNoise, i.uv).rgb;
                if (burn.x > 0.5)
                    discard;
                return fixed4(0, 0, 0, 1);
            }
            ENDCG
        }

        //渲染内部光照
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float3 worldNormal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD2;
            };

            sampler2D _RampTexture;
            sampler2D _OutlineNoise;
            float4 _OutlineNoise_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.worldPos = UnityObjectToWorldDir(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _OutlineNoise);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                fixed diff = dot(worldNormal, worldLightDir) * 0.5 + 0.5;
                float burn = tex2D(_OutlineNoise, i.uv).r / 3;
                diff = diff + burn;

                fixed4 color = tex2D(_RampTexture, float2(diff,diff));
                return color;
            }
            ENDCG
        }
    }
}
