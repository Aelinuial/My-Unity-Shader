﻿Shader "myShader/inkShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _PainterPosition("PainterPosition", Vector) = (0, 0, 0)
        _Radius("Radius", float) = 0.5
        _Hardness("Hardness", float) = 0.5
        _Strength("Strength", float) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            BlendOp Add 
            Blend One One

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
                float4 worldPos : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float3 _PainterPosition;
            float _Radius;
            float _Hardness;
            float _Strength;

            float mask(float3 position, float3 center, float radius, float hardness){
                float m = distance(center, position);
                return 1 - smoothstep(radius * hardness, radius, m);
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = v.uv;
                float4 uv = float4(0, 0, 0, 1);
                uv.xy = (v.uv.xy * 2 - 1) * float2(1, _ProjectionParams.x);
                o.vertex = uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float m = mask(i.worldPos, _PainterPosition, _Radius, _Hardness);
                float edge = m * _Strength;
                return lerp(float4(0, 0, 0, 0), float4(1, 0, 0, 1), edge);
            }
            ENDCG
        }
    }
}
