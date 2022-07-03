Shader "myShader/FireTwist"
{
    Properties
    {
        _DistortTex  ("Texture", 2D) = "white" {}
        _DistortValue("DistortValue",Range(0,1)) = 1
        _DistortSpeed("DistortSpeed",float) = 1
        _Radius ( "_Radius",float ) = 1
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        Cull Off

        GrabPass{"_GrabTex"}

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float2 uv : TEXCOORD0;
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float2 maskUV : TEXCOORD1;
                float4 screenUV : TEXCOORD2;
            };

            sampler2D _GrabTex;
            sampler2D _DistortTex; 
            float4 _DistortTex_ST;
            fixed _DistortValue;
            float _DistortSpeed;
            float _Radius;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); //这个是裁剪空间
                o.uv = TRANSFORM_TEX(v.uv, _DistortTex);
                o.maskUV = v.uv;
                o.screenUV = ComputeScreenPos(o.vertex);//获得的是齐次坐标
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 distortTex = tex2D(_DistortTex, i.uv.xy + _Time.xy * _DistortSpeed);
                float fade = pow(1 - length(i.maskUV - 0.5), _Radius);
                fixed4 col = tex2Dproj(_GrabTex, lerp(i.screenUV, distortTex * fade, _DistortValue));
                return col;
            }
            ENDCG
        }
    }
}
