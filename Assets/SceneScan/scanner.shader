Shader "myShader/Scanner"
{
    Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_ScanDistance("Scan Distance", float) = 0
		_ScanWidth("Scan Width", float) = 10
		_ScanColor("Scan Color", Color) = (1, 1, 1, 0)
	}
    SubShader
	{
		Cull Off
		//ZWrite Off
		ZTest Always

		Pass
		{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata{
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f{
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float2 uv_depth : TEXCOORD1;
            };

            //世界坐标系下的相机位置
            float4 _CameraWS;

            v2f vert(appdata v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv.xy;
                o.uv_depth = v.uv.xy;
                return o;
            }

            sampler2D _MainTex;
            sampler2D _CameraDepthTexture;
            float _ScanDistance;//扫描的距离
            float _ScanWidth;//扫描线的宽度
            float4 _ScanColor;

            half4 frag(v2f i) : SV_Target{
                //采样扫描之前的颜色
                half4 col = tex2D(_MainTex, i.uv);
                //从深度图中采样这个点的深度值
                float depth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, i.uv_depth);
                //转化成线性的深度值
                float linear01Depth = Linear01Depth(depth);

                //深度值在一定的范围内才扫描
                if((linear01Depth > (_ScanDistance - _ScanWidth)) && (linear01Depth < _ScanDistance) && (linear01Depth < 1)){
                    //可以制作出渐变的效果
                    float diff = 1 - (_ScanDistance - linear01Depth) / _ScanWidth;
                    _ScanColor *= diff;
                    return col + _ScanColor;
                }
                return col;
            }
            ENDCG
        }
    }
}
