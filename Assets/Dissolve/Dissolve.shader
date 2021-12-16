Shader "myShader/Dissolve"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _DissolveTex ("Dissolve Texture", 2D) = "white" {}
        [HDR]_DissolveColor("Dissolve Color", Color) = (1, 0, 0, 0)
        _DissolveEdge("Dissolve Edge", float) = 0.2
        _ClipThreshold("Clip Threshold", float) = 0.2
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
                float2 uvMain : TEXCOORD0;
                float2 uvDissolve : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _DissolveTex;
            float4 _DissolveTex_ST;
            fixed4 _DissolveColor;
            float _DissolveEdge;
            float _ClipThreshold;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uvMain = TRANSFORM_TEX(v.uv, _MainTex);
                o.uvDissolve = TRANSFORM_TEX(v.uv, _DissolveTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 mainCol = tex2D(_MainTex, i.uvMain);
                fixed clipCol = tex2D(_DissolveTex, i.uvDissolve).r;
                fixed4 edgeColor = fixed4(1, 1, 1, 1);
                float t = clipCol - _ClipThreshold;
                clip(t);
                if(t < _DissolveEdge){
                    edgeColor = lerp(_DissolveColor, edgeColor, t);
                }
                return mainCol * edgeColor;
            }
            ENDCG
        }
    }
}
