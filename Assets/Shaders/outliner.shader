Shader "myShader/outliner"
{
    Properties
    {
        [Header(OutLine)]
        _OutlineColor("Outline Color", Color) = (0, 0, 0, 1)
        _OutlineNoise("Outline Noise", 2D) = "white"{}
        _OutlineWidth("Outline Width", Range(0, 1)) = 0.1
        _OutlineWidthS("Outline Width Second", Range(0, 1)) = 0.2

        [Header(Interior)]
        _RampTexture ("Ramp Texture", 2D) = "white" {}
        _InkTexture("Ink Texture", 2D) = "white"{}
        _InteriorNoiseLevel ("Interior Noise Level", Range(0, 1)) = 0.15
        // Guassian Blur
        _Radius ("Guassian Blur Radius", Range(0, 60)) = 30
        _Resolution ("Resolution", float) = 800
        _Hstep("HorizontalStep", Range(0, 1)) = 0.5
        _Vstep("VerticalStep", Range(0, 1)) = 0.5
    }
    SubShader
    {
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

            float4 _OutlineColor;
            sampler2D _OutlineNoise;
            float4 _OutlineNoise_ST;
            float _OutlineWidth;

            v2f vert (appdata v)
            {
                float4 burn = tex2Dlod(_OutlineNoise, v.vertex);

                v2f o;

                float4 viewPos = mul(UNITY_MATRIX_MV, v.vertex);
                float3 viewNormal = mul((float3x3)UNITY_MATRIX_MV, v.normal);
                viewNormal.z = -0.5;
                viewNormal = normalize(viewNormal);
                viewPos = viewPos + float4(viewNormal, 0) * burn.x * _OutlineWidth;

                o.vertex = mul(UNITY_MATRIX_P, viewPos);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return _OutlineColor;
            }
            ENDCG
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

            float4 _OutlineColor;
            sampler2D _OutlineNoise;
            float4 _OutlineNoise_ST;
            float _OutlineWidthS;

            v2f vert (appdata v)
            {
                float4 burn = tex2Dlod(_OutlineNoise, v.vertex);

                v2f o;

                float4 viewPos = mul(UNITY_MATRIX_MV, v.vertex);
                float3 viewNormal = mul((float3x3)UNITY_MATRIX_MV, v.normal);
                viewNormal.z = -0.5;
                viewNormal = normalize(viewNormal);
                viewPos = viewPos + float4(viewNormal, 0) * burn.x * _OutlineWidthS;

                o.vertex = mul(UNITY_MATRIX_P, viewPos);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 c = _OutlineColor;
                fixed3 burn = tex2D(_OutlineNoise, i.uv).rgb;
                if (burn.x > 0.5)
                    discard;
                return c;
            }
            ENDCG
        }

        Pass
        {
            Tags{"LightMode" = "ForwardBase"}
            Cull Back

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            #include "UnityCG.cginc"

            sampler2D _OutlineNoise;
            sampler2D _RampTexture;
            sampler2D _InkTexture;
            float _InteriorNoiseLevel;
            float _Radius;
            float _Resolution;
            float _Hstep;
            float _Vstep;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv :TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv :TEXCOORD0;
                float3 worldNormal : TEXCOORD1;
                float3 worldPos : TEXCOORD2;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = UnityObjectToWorldDir(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 worldNormal = normalize(i.worldNormal);
                float3 worldLight = normalize(UnityWorldSpaceLightDir(i.worldPos));
                float4 burn = tex2D(_OutlineNoise, i.uv);
                float diff = dot(worldNormal, worldLight);
                diff = (diff + 1.0) / 2;
                float2 k = tex2D(_InkTexture, i.uv).xy;
                float2 cuv = float2(diff, diff) + k * burn.xy * _InteriorNoiseLevel;
                //float2 cuv = float2(diff, diff);

                float4 sum = float4(0.0, 0.0, 0.0, 0.0);
                float2 tc = cuv;
                float blur = _Radius / _Resolution / 4;
                sum += tex2D(_RampTexture, float2(tc.x - 4.0 * blur * _Hstep, tc.y - 4.0 * blur * _Vstep)) * 0.0162162162;
                sum += tex2D(_RampTexture, float2(tc.x - 3.0 * blur * _Hstep, tc.y - 3.0 * blur * _Vstep)) * 0.0540540541;
                sum += tex2D(_RampTexture, float2(tc.x - 2.0 * blur * _Hstep, tc.y - 2.0 * blur * _Vstep)) * 0.1216216216;
                sum += tex2D(_RampTexture, float2(tc.x - 1.0 * blur * _Hstep, tc.y - 1.0 * blur * _Vstep)) * 0.1945945946;
                sum += tex2D(_RampTexture, float2(tc.x, tc.y)) * 0.2270270270;
                sum += tex2D(_RampTexture, float2(tc.x + 1.0 * blur * _Hstep, tc.y + 1.0 * blur * _Vstep)) * 0.1945945946;
                sum += tex2D(_RampTexture, float2(tc.x + 2.0 * blur * _Hstep, tc.y + 2.0 * blur * _Vstep)) * 0.1216216216;
                sum += tex2D(_RampTexture, float2(tc.x + 3.0 * blur * _Hstep, tc.y + 3.0 * blur * _Vstep)) * 0.0540540541;
                sum += tex2D(_RampTexture, float2(tc.x + 4.0 * blur * _Hstep, tc.y + 4.0 * blur * _Vstep)) * 0.0162162162;

				return float4(sum.rgb, 1.0);
            }
            ENDCG
        }
    }
}
