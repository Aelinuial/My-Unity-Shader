Shader "myShader/StippleTransparency"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Alpha ("Alpha", Range(0,1)) = 1.0
    }

    SubShader
    {
        Tags
        { 
            "RenderType"="Opaque"
            "Queue" = "Geometry"
        }

        LOD 100

        Pass
        {
            Tags
            {
                "LightMode" = "ForwardBase"
            }

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
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 screenPos : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            half _Alpha;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.screenPos = ComputeScreenPos (o.pos);

                return o;
            }

            float4 frag (v2f i) : COLOR {
                fixed4 c = tex2D(_MainTex, i.uv);

                //其实这里面的顺序无所谓，不过脑补中觉得乱序效果比较好
                /*
                float4x4 thresholdMatrix =
                {  1.0 / 17.0,  9.0 / 17.0,  3.0 / 17.0, 11.0 / 17.0,
                  13.0 / 17.0,  5.0 / 17.0, 15.0 / 17.0,  7.0 / 17.0,
                   4.0 / 17.0, 12.0 / 17.0,  2.0 / 17.0, 10.0 / 17.0,
                  16.0 / 17.0,  8.0 / 17.0, 14.0 / 17.0,  6.0 / 17.0
                };
                */

                float4x4 thresholdMatrix =
                {  1.0 / 17.0,  2.0 / 17.0,  3.0 / 17.0, 4.0 / 17.0,
                  5.0 / 17.0,  6.0 / 17.0, 7.0 / 17.0,  8.0 / 17.0,
                   9.0 / 17.0, 10.0 / 17.0,  11.0 / 17.0, 12.0 / 17.0,
                  13.0 / 17.0,  14.0 / 17.0, 15.0 / 17.0,  16.0 / 17.0
                };

                float4x4 _RowAccess = { 1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1 };
                float2 pos = i.screenPos.xy / i.screenPos.w;
                pos *= _ScreenParams.xy;

                clip(_Alpha - thresholdMatrix[fmod(pos.x, 4)] * _RowAccess[fmod(pos.y, 4)]);

                return c;
            }
            ENDCG
        }
    }
    Fallback "Mobile/VertexLit"
}