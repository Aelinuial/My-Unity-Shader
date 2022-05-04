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
        _BrushTexture("Brush Texture", 2D) = "white"{}

        [Header(ModelTexture)]
        _ModelTexture("Model Texture", 2D) = "white"{}
        _CutThreshold("Cut Threshold", Range(0, 1)) = 0.5
        _ShadowPower("Shadow Power", float) = 1.0
    }
    SubShader
    {
        Tags { 
            "LIGHTMODE" = "FORWARDBASE" 
            "SHADOWSUPPORT" = "true" 
            "RenderType" = "Opaque"
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
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float4 _StrokeColor;
            sampler2D _OutlineNoise;
            float _OutlineWidth;
            float _OutsideNoiseWidth;
            float _MaxOutlineOffset;
            sampler2D _ModelTexture;
            float4 _ModelTexture_ST;
            float _CutThreshold;

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
                o.uv = TRANSFORM_TEX(v.uv, _ModelTexture);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float texAlpha = tex2D(_ModelTexture, i.uv).a;
                clip(texAlpha - _CutThreshold);
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
                float4 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float4 _StrokeColor;
            sampler2D _OutlineNoise;
            float4 _OutlineNoise_ST;
            float _OutlineWidth;
            float _OutsideNoiseWidth;
            float _MaxOutlineOffset;
            sampler2D _ModelTexture;
            float4 _ModelTexture_ST;
            float _CutThreshold;

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
                o.uv.xy = TRANSFORM_TEX(v.uv, _OutlineNoise);
                o.uv.zw = TRANSFORM_TEX(v.uv, _ModelTexture);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float texAlpha = tex2D(_ModelTexture, i.uv.zw).a;
                clip(texAlpha - _CutThreshold);

                fixed3 burn = tex2D(_OutlineNoise, i.uv.xy).rgb;
                if (burn.x > 0.5)
                    discard;
                return fixed4(0, 0, 0, 1);
            }
            ENDCG
        }

        //渲染内部光照
        Pass
        {
            ZWrite On
            ZTest On

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase

            #include "UnityCG.cginc"
            #include "AutoLight.cginc"

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
                float4 pos : SV_POSITION;
                float4 uv : TEXCOORD2;
                SHADOW_COORDS(3)
            };

            sampler2D _RampTexture;
            sampler2D _OutlineNoise;
            float4 _OutlineNoise_ST;
            sampler2D _ModelTexture;
            float4 _ModelTexture_ST;
            float _CutThreshold;
            float _ShadowPower;

            v2f vert (appdata v)
            {
                v2f o;
                o.worldPos = UnityObjectToWorldDir(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv.xy = TRANSFORM_TEX(v.uv, _OutlineNoise);
                o.uv.zw = TRANSFORM_TEX(v.uv, _ModelTexture);
                TRANSFER_SHADOW(o)
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float texAlpha = tex2D(_ModelTexture, i.uv.zw).a;
                clip(texAlpha - _CutThreshold);

                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                fixed diff = dot(worldNormal, worldLightDir) * 0.5 + 0.5;
                float burn = tex2D(_OutlineNoise, i.uv.xy).r / 3;
                diff = diff + burn * _ShadowPower;

                fixed shadow = SHADOW_ATTENUATION(i);
                if(shadow == 0.0f) diff = 0.0f;

                fixed4 color = tex2D(_RampTexture, float2(diff,diff));
                return color;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
