Shader "myPostEffect/PostEffectBlood"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BloodTex("Blood Texture" , 2D) = "white" {}
        _BloodStatus("Blood Status", Range(0, 5)) = 0
        _Flash("Flash", int) = 1
        _FlashSpeed("Flash Speed", Range(0, 3)) = 0
    }
    SubShader
    {
        Tags {  
            "RenderType"="Opaque"
			"Queue"="Geometry"
        }

        Pass
        {
            ZTest Always
            Cull OFF 
            ZWrite Off 

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
                float4 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _BloodTex;
            float4 _BloodTex_ST;
            float _BloodStatus;
            float _FlashSpeed;
            int _Flash;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv.xy = v.uv;
                o.uv.zw = TRANSFORM_TEX(v.uv, _BloodTex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                float4 col = tex2D(_MainTex, i.uv.xy);
                float4 bloodcol = tex2D(_BloodTex, i.uv.zw);
                bloodcol.a *= _BloodStatus;
                if(_Flash == 1){
                    bloodcol.a *= abs(sin(_Time.y * _FlashSpeed));
                }
                float3 finalCol =  col.rgb * (1 - bloodcol.a) + bloodcol.rgb * bloodcol.a;

                return float4(finalCol, 1.);
            }
            ENDCG
        }
    }
}
