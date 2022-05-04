Shader "myShader/Fresnel"
{
    Properties
    {
        _MainAlpha("Main Alpha", Range(0, 1)) = 0.3
        _FresnelPow ("Fresnel Power",float) = 1
        [HDR]_FresnelColor("Fresnel Color",COLOR) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { 
            "RenderType" = "Transparent" 
            "RenderQueue" = "Transparent" 
        }
        Blend SrcAlpha OneMinusSrcAlpha
        Zwrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "AutoLight.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normalDir : TEXCOORD1;
                float4 worldPos : TEXCOORD2;
            };

            float _MainAlpha;
            float _FresnelPow;
            fixed4 _FresnelColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld,v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                float4 texColor = float4(1, 1, 1, _MainAlpha);
                i.normalDir = normalize(i.normalDir);
                float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                float dotValue = pow(1 - saturate(dot(i.normalDir,viewDir)),_FresnelPow);
                fixed4 resultColor = _FresnelColor * texColor;
                resultColor.rgb *= dotValue;
                return float4(resultColor.rgb, _MainAlpha);
            }
            ENDCG
        }
    }
}

