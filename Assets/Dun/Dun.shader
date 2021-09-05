// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:39679,y:34064,varname:node_3138,prsc:2|emission-4747-OUT,alpha-2196-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32471,y:32812,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_Tex2d,id:8668,x:32646,y:32999,ptovrint:False,ptlb:GridTex,ptin:_GridTex,varname:node_8668,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d1ec9c32b36330249b7874e5db9d6511,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:5803,x:33770,y:33173,varname:node_5803,prsc:2|A-7241-RGB,B-8668-RGB,C-4817-OUT;n:type:ShaderForge.SFN_Time,id:8197,x:32182,y:33366,varname:node_8197,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:7428,x:31871,y:33108,varname:node_7428,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Sin,id:2066,x:32583,y:33239,varname:node_2066,prsc:2|IN-4461-OUT;n:type:ShaderForge.SFN_Add,id:4461,x:32402,y:33266,varname:node_4461,prsc:2|A-7454-OUT,B-8197-T;n:type:ShaderForge.SFN_Multiply,id:7454,x:32219,y:33204,varname:node_7454,prsc:2|A-7428-V,B-5364-OUT;n:type:ShaderForge.SFN_Vector1,id:5364,x:31976,y:33328,varname:node_5364,prsc:2,v1:10;n:type:ShaderForge.SFN_Clamp01,id:4807,x:32751,y:33207,varname:node_4807,prsc:2|IN-2066-OUT;n:type:ShaderForge.SFN_Multiply,id:4817,x:33271,y:33217,varname:node_4817,prsc:2|A-8668-A,B-4807-OUT;n:type:ShaderForge.SFN_Tex2d,id:8133,x:33487,y:33653,ptovrint:False,ptlb:GridBack,ptin:_GridBack,varname:node_8133,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6ec173034987c8e4091d43381a613881,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:9998,x:34272,y:33673,varname:node_9998,prsc:2|A-8133-R,B-5714-OUT;n:type:ShaderForge.SFN_Sin,id:9384,x:33435,y:33470,varname:node_9384,prsc:2|IN-9671-T;n:type:ShaderForge.SFN_Time,id:9671,x:32990,y:33688,varname:node_9671,prsc:2;n:type:ShaderForge.SFN_Abs,id:5714,x:33904,y:33415,varname:node_5714,prsc:2|IN-9384-OUT;n:type:ShaderForge.SFN_Color,id:5794,x:34559,y:33990,ptovrint:False,ptlb:Color2,ptin:_Color2,varname:node_5794,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.0896554,c3:1,c4:0.434;n:type:ShaderForge.SFN_Multiply,id:4496,x:34920,y:33497,varname:node_4496,prsc:2|A-8813-OUT,B-5794-RGB;n:type:ShaderForge.SFN_Multiply,id:253,x:34906,y:33659,varname:node_253,prsc:2|A-8813-OUT,B-5794-A;n:type:ShaderForge.SFN_Fresnel,id:2828,x:34757,y:33158,varname:node_2828,prsc:2|EXP-739-OUT;n:type:ShaderForge.SFN_Slider,id:739,x:34383,y:33083,ptovrint:False,ptlb:fresnelExp,ptin:_fresnelExp,varname:node_739,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.6901146,max:10;n:type:ShaderForge.SFN_Add,id:8573,x:35713,y:33437,varname:node_8573,prsc:2|A-2828-OUT,B-5803-OUT,C-4496-OUT;n:type:ShaderForge.SFN_Add,id:5575,x:35210,y:33685,varname:node_5575,prsc:2|A-2828-OUT,B-253-OUT;n:type:ShaderForge.SFN_Multiply,id:3597,x:34230,y:33954,varname:node_3597,prsc:2|A-8133-B,B-2427-OUT;n:type:ShaderForge.SFN_Cos,id:7671,x:33416,y:33905,varname:node_7671,prsc:2|IN-9671-T;n:type:ShaderForge.SFN_Abs,id:2427,x:33728,y:34041,varname:node_2427,prsc:2|IN-7671-OUT;n:type:ShaderForge.SFN_Add,id:8813,x:34496,y:33704,varname:node_8813,prsc:2|A-9998-OUT,B-3597-OUT;n:type:ShaderForge.SFN_Clamp01,id:2131,x:35610,y:33637,varname:node_2131,prsc:2|IN-5575-OUT;n:type:ShaderForge.SFN_Depth,id:1501,x:35298,y:34047,varname:node_1501,prsc:2;n:type:ShaderForge.SFN_SceneDepth,id:848,x:35286,y:33916,varname:node_848,prsc:2;n:type:ShaderForge.SFN_Subtract,id:656,x:35610,y:33873,varname:node_656,prsc:2|A-848-OUT,B-1501-OUT;n:type:ShaderForge.SFN_OneMinus,id:7957,x:35939,y:33895,varname:node_7957,prsc:2|IN-2493-OUT;n:type:ShaderForge.SFN_Multiply,id:6740,x:36181,y:34027,varname:node_6740,prsc:2|A-8672-RGB,B-7957-OUT;n:type:ShaderForge.SFN_Add,id:9721,x:36473,y:33673,varname:node_9721,prsc:2|A-8573-OUT,B-6740-OUT;n:type:ShaderForge.SFN_Clamp01,id:2493,x:35772,y:33873,varname:node_2493,prsc:2|IN-656-OUT;n:type:ShaderForge.SFN_Color,id:8672,x:35786,y:34260,ptovrint:False,ptlb:CrossCol,ptin:_CrossCol,varname:node_8672,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.1172414,c2:0,c3:1,c4:1;n:type:ShaderForge.SFN_Add,id:3097,x:39108,y:34339,varname:node_3097,prsc:2|A-2131-OUT,B-7957-OUT,C-14-OUT;n:type:ShaderForge.SFN_Distance,id:3589,x:36610,y:34446,varname:node_3589,prsc:2|A-8195-XYZ,B-5534-XYZ;n:type:ShaderForge.SFN_FragmentPosition,id:5534,x:36351,y:34416,varname:node_5534,prsc:2;n:type:ShaderForge.SFN_Vector4Property,id:8195,x:36284,y:34276,ptovrint:False,ptlb:Pos,ptin:_Pos,varname:node_8195,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_OneMinus,id:3401,x:37464,y:34591,varname:node_3401,prsc:2|IN-5994-OUT;n:type:ShaderForge.SFN_Code,id:5994,x:36941,y:34584,varname:node_5994,prsc:2,code:aQBmACgAVgBhAGwAdQBlADwATQBpAG4AKQBWAGEAbAB1AGUAPQBNAGkAbgA7AAoAZQBsAHMAZQAgAGkAZgAoAFYAYQBsAHUAZQA+AE0AYQB4ACkAVgBhAGwAdQBlAD0ATQBhAHgAOwAKAGYAbABvAGEAdAAgAGwAZQBuAGcAdABoACAAPQAgACgATQBhAHgALQBNAGkAbgApADsACgByAGUAdAB1AHIAbgAgAFYAYQBsAHUAZQAvAGwAZQBuAGcAdABoADsACgA=,output:0,fname:Clamp01,width:408,height:132,input:0,input:0,input:0,input_1_label:Value,input_2_label:Min,input_3_label:Max|A-3589-OUT,B-3405-OUT,C-4041-OUT;n:type:ShaderForge.SFN_Vector1,id:3405,x:36610,y:34635,varname:node_3405,prsc:2,v1:0;n:type:ShaderForge.SFN_Slider,id:4041,x:36507,y:34846,ptovrint:False,ptlb:Size,ptin:_Size,varname:node_4041,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:10;n:type:ShaderForge.SFN_Sin,id:4614,x:38050,y:34600,varname:node_4614,prsc:2|IN-610-OUT;n:type:ShaderForge.SFN_Add,id:5959,x:37668,y:34655,varname:node_5959,prsc:2|A-3401-OUT,B-8453-OUT;n:type:ShaderForge.SFN_Multiply,id:9421,x:38254,y:34409,varname:node_9421,prsc:2|A-3401-OUT,B-4614-OUT;n:type:ShaderForge.SFN_Multiply,id:610,x:37837,y:34698,varname:node_610,prsc:2|A-5959-OUT,B-7316-OUT;n:type:ShaderForge.SFN_Vector1,id:7316,x:37682,y:34894,varname:node_7316,prsc:2,v1:10;n:type:ShaderForge.SFN_Add,id:4747,x:39080,y:34181,varname:node_4747,prsc:2|A-9721-OUT,B-14-OUT;n:type:ShaderForge.SFN_Clamp01,id:4306,x:38473,y:34339,varname:node_4306,prsc:2|IN-9421-OUT;n:type:ShaderForge.SFN_Multiply,id:14,x:38650,y:34411,varname:node_14,prsc:2|A-4306-OUT,B-9603-OUT,C-571-OUT;n:type:ShaderForge.SFN_Vector1,id:9603,x:38293,y:34600,varname:node_9603,prsc:2,v1:2;n:type:ShaderForge.SFN_ValueProperty,id:571,x:37323,y:35178,ptovrint:False,ptlb:mTime,ptin:_mTime,varname:node_571,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_OneMinus,id:8453,x:37501,y:34927,varname:node_8453,prsc:2|IN-571-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4730,x:33363,y:33960,ptovrint:False,ptlb:rotation_copy,ptin:_rotation_copy,varname:_rotation_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:10;n:type:ShaderForge.SFN_Add,id:2196,x:39426,y:34439,varname:node_2196,prsc:2|A-3097-OUT,B-6080-OUT;n:type:ShaderForge.SFN_Vector1,id:6080,x:39237,y:34439,varname:node_6080,prsc:2,v1:0.1;proporder:7241-8668-8133-5794-739-8672-8195-4041-571;pass:END;sub:END;*/

Shader "Custom/Shield" {
    Properties {
        _Color ("Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _GridTex ("GridTex", 2D) = "white" {}
        _GridBack ("GridBack", 2D) = "white" {}
        _Color2 ("Color2", Color) = (0,0.0896554,1,0.434)
        _fresnelExp ("fresnelExp", Range(0, 10)) = 0.6901146
        _CrossCol ("CrossCol", Color) = (0.1172414,0,1,1)
        _Pos ("Pos", Vector) = (0,0,0,0)
        _Size ("Size", Range(1, 10)) = 1
        _mTime ("mTime", Float ) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _GridTex; uniform float4 _GridTex_ST;
            uniform sampler2D _GridBack; uniform float4 _GridBack_ST;
            uniform float4 _Color2;
            uniform float _fresnelExp;
            uniform float4 _CrossCol;
            uniform float4 _Pos;
            float Clamp01( float Value , float Min , float Max ){
            if(Value<Min)Value=Min;
            else if(Value>Max)Value=Max;
            float length = (Max-Min);
            return Value/length;
            
            }
            
            uniform float _Size;
            uniform float _mTime;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float4 projPos : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
////// Lighting:
////// Emissive:
                float node_2828 = pow(1.0-max(0,dot(normalDirection, viewDirection)),_fresnelExp);
                float4 _GridTex_var = tex2D(_GridTex,TRANSFORM_TEX(i.uv0, _GridTex));
                float4 node_8197 = _Time + _TimeEditor;
                float node_4817 = (_GridTex_var.a*saturate(sin(((i.uv0.g*10.0)+node_8197.g))));
                float3 node_5803 = (_Color.rgb*_GridTex_var.rgb*node_4817);
                float4 _GridBack_var = tex2D(_GridBack,TRANSFORM_TEX(i.uv0, _GridBack));
                float4 node_9671 = _Time + _TimeEditor;
                float node_8813 = ((_GridBack_var.r*abs(sin(node_9671.g)))+(_GridBack_var.b*abs(cos(node_9671.g))));
                float node_7957 = (1.0 - saturate((sceneZ-partZ)));
                float node_3401 = (1.0 - Clamp01( distance(_Pos.rgb,i.posWorld.rgb) , 0.0 , _Size ));
                float node_14 = (saturate((node_3401*sin(((node_3401+(1.0 - _mTime))*10.0))))*2.0*_mTime);
                float3 emissive = (((node_2828+node_5803+(node_8813*_Color2.rgb))+(_CrossCol.rgb*node_7957))+node_14);
                float3 finalColor = emissive;
                return fixed4(finalColor,((saturate((node_2828+(node_8813*_Color2.a)))+node_7957+node_14)+0.1));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
