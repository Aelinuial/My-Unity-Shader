Shader "myShader/TriplanarNoiseCloudDissolve"
{
    Properties{
        _Color("Color", Color) = (1,1,1,1)
        _Noise("Noise", 2D) = "gray" {}
        _TColor("Cloud Top Color", Color) = (1,0.6,1,1)
        _CloudColor("Cloud Base Color", Color) = (0.6,1,1,1)
        _ShadowColor("Shadow Color", Color) = (0.1, 1, 1, 1)
        _RimColor("Rim Color", Color) = (0.6,1,1,1)
        _RimPower("Rim Power", Range(0,40)) = 20
        _RimIntensity("Rim Intensity", Range(0,20)) = 10
        _Scale("World Scale", float) = 0.004
        _AnimSpeedX("Animation Speed X", Range(-2,2)) = 1
        _AnimSpeedY("Animation Speed Y", Range(-2,2)) = 1
        _AnimSpeedZ("Animation Speed Z", Range(-2,2)) = 1
        _Height("Noise Height", Range(0,2)) = 0.8
        _Strength("Noise Emission Strength", Range(0,2)) = 0.3

        [Header(Disappear)]
        [IntRange]_IsLocal("Use Local Height", Range(0, 1)) = 0
        _LocalLerpHeight("Local Lerp Height", float) = 0
        _WorldLerpHeight("World Lerp Height", float) = 0
    }
 
    SubShader{
        Tags { 
            "Queue"="Transparent" 
            "RenderType"="Transparent" 
        }
        Blend SrcAlpha OneMinusSrcAlpha

        Pass{
            CGPROGRAM
            #pragma vertex vert 
            #pragma fragment frag 
            #include "UnityCG.cginc"
        
            sampler2D _Noise;
            float4 _Color, _CloudColor, _TColor, _RimColor, _ShadowColor;
            float _Scale, _Strength, _RimPower, _RimIntensity, _Height;
            float _AnimSpeedX, _AnimSpeedY, _AnimSpeedZ;
            float _LocalLerpHeight, _WorldLerpHeight;
            int _IsLocal;
    
            struct appdata{
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };

            struct v2f{
                float4 vertex : SV_POSITION;
                float4 worldPos : TEXCOORD0;
                float3 worldNormal : TEXCOORD1;
                float4 rawVert : TEXCOORD2;
                float3 viewDir : TEXCOORD3;
                float4 localPos : TEXCOORD4;
            };

            v2f vert(appdata v){
                v2f o;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                float3 worldNormalEdit = saturate(pow(o.worldNormal * 1.4, 4));
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.localPos = v.vertex;

                float movementSpeedX = _Time.x * _AnimSpeedX;
                float movementSpeedY = _Time.x * _AnimSpeedY;
                float movementSpeedZ = _Time.x * _AnimSpeedZ;

                float2 xy = float2((o.worldPos.x * _Scale) - movementSpeedX, (o.worldPos.y * _Scale) - movementSpeedY);
                float2 xz = float2((o.worldPos.x * _Scale) - movementSpeedX, (o.worldPos.z * _Scale) - movementSpeedZ);
                float2 yz = float2((o.worldPos.y * _Scale) - movementSpeedY, (o.worldPos.z * _Scale) - movementSpeedZ);

                float4 noiseXY = tex2Dlod(_Noise, float4(xy, 0, 0));
                float4 noiseXZ = tex2Dlod(_Noise, float4(xz, 0, 0));
                float4 noiseYZ = tex2Dlod(_Noise, float4(yz, 0, 0));

                float4 noiseCombine = noiseXY;
                noiseCombine = lerp(noiseCombine, noiseXZ, worldNormalEdit.y);
                noiseCombine = lerp(noiseCombine, noiseYZ, worldNormalEdit.x);

                v.vertex.xyz += (v.normal * (noiseCombine * _Height));
                o.rawVert = v.vertex;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.viewDir = normalize(WorldSpaceViewDir(v.vertex));
                return o;
            }

            fixed4 frag(v2f i) : SV_Target{
                float4 cloudColor = lerp(_CloudColor, _TColor, i.rawVert.y);

                float3 viewDir = i.viewDir;
                float3 normalDir = normalize(i.worldNormal);

                float rim = 1.0 - max(0, dot(normalDir, viewDir));
                float3 rimEmissive = _RimColor * pow(rim, _RimPower) * _RimIntensity;

                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                float NdotL = saturate(max(0, dot(i.worldNormal, lightDir)));
                
                //lerp
                float3 finalCol = lerp(_ShadowColor * 1.1, cloudColor * 1.6, NdotL) + rimEmissive;

                float alpha = 1.0f;
                //alpha
                if(_IsLocal == 0){
                    float heightDis = saturate(i.localPos.y - _LocalLerpHeight);
                    alpha = lerp(0.f, 1.f, heightDis);
                    alpha = saturate(alpha);
                }
                else{
                    float heightDis = saturate(i.worldPos.y - _WorldLerpHeight);
                    alpha = lerp(0.f, 5.f, heightDis);
                    alpha = saturate(alpha);
                }

                return float4(finalCol, alpha);
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}