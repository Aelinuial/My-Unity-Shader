Shader "myShader/Dissolve"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

		[Vector2(1)] _DissolveCenterUV("Dissolve Center UV", Vector) = (0,1,0)
		_WorldSpaceScale("World Space Dissolve Factor", float) = 0.1

		_DissTex("Dissolve Texture", 2D) = "white"{}

		[ScaleOffset] _DissTex_Scroll("Scroll", Vector) = (0, 0, 0, 0)

		_Clip("Clip", Range(0, 3.)) = 0
    }
    SubShader
    {
		Tags {
            "IgnoreProjector" = "True"
            "RenderType" = "Transparent" 
            "Queue" = "Transparent"
        }

        Pass
        {
			Blend SrcAlpha OneMinusSrcAlpha

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
                float4 vertex : SV_POSITION;
				float4 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
			sampler2D _DissTex;
            float4 _MainTex_ST;
			float4 _DissTex_ST;
			float2 _DissolveCenterUV;
			float _Clip;
			float _WorldSpaceScale;

			float2 _DissTex_Scroll;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv.zw = TRANSFORM_TEX(v.uv, _DissTex) + frac(_DissTex_Scroll.xy * _Time.x);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv.xy);
				fixed dissove = tex2D(_DissTex, i.uv.zw).r;

				float dist = distance(_DissolveCenterUV, i.uv.xy);

				dissove = dissove + dist * _WorldSpaceScale;
                if(dissove > col.a) dissove = col.a;

				float dissolve_alpha = col.a + dissove - _Clip;
				//clip(dissolve_alpha - 0.5);
                float alpha = saturate(dissolve_alpha);

                return float4(col.rgb, alpha);
            }
            ENDCG
        }
    }
}
