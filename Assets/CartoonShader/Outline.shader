Shader "myShader/Outline"
{
    Properties
    {
        [Header(OutLine)]
        _OutlineWidth("Outline Width", Range(0, 1)) = 0.1
        _OutlineColor("Outline Color", Color) = (1, 1, 1, 1)
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
            NAME "OUTLINE"
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 vertexColor : COLOR0;
            };

            struct v2f
            {
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            fixed4 _OutlineColor;
            half _OutlineWidth;

            v2f vert(a2v v)
            {
                v2f o;
                //从顶点颜色中读取法线信息，并将其值范围从0~1还原为-1~1
                float3 vertNormal = v.vertexColor.rgb * 2 - 1;
                //使用法线与切线叉乘计算副切线用于构建切线→模型空间转换矩阵
                float3 bitangent = cross(v.normal,v.tangent.xyz) * v.tangent.w * unity_WorldTransformParams.w;
                //构建切线→模型空间转换矩阵
                float3x3 TtoO = float3x3(v.tangent.x, bitangent.x, v.normal.x,
                                        v.tangent.y, bitangent.y, v.normal.y,
                                        v.tangent.z, bitangent.z, v.normal.z);
                //将法线转换到模型空间下
                vertNormal = mul(TtoO, vertNormal);
                //模型坐标 + 法线 * 自定义粗细值 * 顶点颜色A通道 = 轮廓线模型					
                o.vertex = UnityObjectToClipPos(v.vertex + vertNormal *_OutlineWidth * v.vertexColor.a);
                return o;
            }
            fixed4 frag(v2f i) : SV_Target
            {
                return _OutlineColor;
            }
            ENDCG
        }

/*
        //内部
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
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 color = fixed4(1, 1, 1, 1);
                return color;
            }
            ENDCG
        }
*/
    }
    Fallback "Diffuse"
}
