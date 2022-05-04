Shader "myPostEffect/Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Edge ("Edge", float) = 0.1
        _Width("Width", int) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

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
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float2 dxy : TEXCOORD1;
            };

            sampler2D _MainTex;
            sampler2D _CameraDepthTexture;
            float2 _MainTex_TexelSize;
            float _Edge;
            float _Width;

            fixed luminance(fixed4 color){
                return color.r * 0.33 + color.g * 0.33 + color.b * 0.33;
            }

            half edge(half2 uv, float2 xy){
                half offset = 0;
                half center = Linear01Depth(UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, uv)));
                //计算这个像素和周围像素的深度差之和
                for (int i = -_Width; i < _Width + 1; i++){
                    for (int j = -_Width; j < _Width + 1; j++){
                        offset += center - Linear01Depth(UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, uv + half2(i * xy.x, j * xy.y))));
                    }
                }
                return abs(offset) * 10000;
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.dxy = _MainTex_TexelSize.xy;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 color = tex2D(_MainTex, i.uv);
                float rate = edge(i.uv, i.dxy);
                rate = rate > _Edge ? 0 : 1;
                
                return color * rate;
            }
            ENDCG
        }
    }
}
