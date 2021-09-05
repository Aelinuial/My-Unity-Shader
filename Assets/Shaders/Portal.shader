Shader "myShader/Portal"
{
    Properties
    {
        _FeatureTex ("FeatureTex", 2D) = "white" {}
        _OutlineNoiseTex("_OutlineNoiseTex", 2D) = "white" {}
        _MainTex ("MainTex", 2D) = "white" {}
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

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _OutlineNoiseTex;
            sampler2D _OutlineNoiseTex_ST;
            sampler2D _FeatureTex;
            float4 _FeatureTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 newuv = i.uv + sin(tex2D(_OutlineNoiseTex, i.uv + float2(_Time.y, -_Time.y)).x * 6) * tex2D(_OutlineNoiseTex, i.uv).xy / 5;
                fixed4 fcol = tex2D(_FeatureTex, newuv);
                clip(0.5 - fcol.a);
                return float4(1, 0, 0, 1);
            }
            ENDCG
        }
    }
}
