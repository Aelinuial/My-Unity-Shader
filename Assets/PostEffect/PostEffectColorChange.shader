Shader "myPostEffect/ColorChange"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Brightness("Brightness", float) = 1.0
        _Saturation("Saturation", float) = 1.0
        _Contrast("Contrast", float) = 1.0
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

            sampler2D _MainTex;
            float _Brightness;
            float _Saturation;
            float _Contrast;

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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                float4 col = tex2D(_MainTex, i.uv);
                float3 finalCol = col.rgb * _Brightness;

                float luminance = 0.2125 * col.r + 0.7154 * col.g + 0.0721 * col.b;
                float3 luminanceCol = float3(luminance, luminance, luminance);
                finalCol = lerp(luminanceCol, finalCol, _Saturation);

                float3 avgCol = float3(0.5, 0.5, 0.5);
                finalCol = lerp(avgCol, finalCol, _Contrast);
                
                return float4(finalCol, col.a);
            }
            ENDCG
        }
    }
}
