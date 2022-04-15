Shader "myShader/passFur"
{
    Properties
    {
        _furTex("Fur Texture", 2D) = "white" {}
        _furMaskTex("Fur Mask Texture", 2D) = "white" {}
        _noiseTex ("Noise Texture", 2D) = "white" {}
        _furLength("Fur Length", float) = 0.5
        _furRadius("Fur Radius", float) = 0.1
        _uvOffset("UV Offset", vector) = (0, 0, 0.2, 0.2)
        _occlusionPower("Occlusion Power", float) = 0.5
        _occlusionColor("Occlusion Color", Color) = (1, 1, 1, 1)
    }

    category{

        Tags{
            "LightMode" = "ForwardBase"
            "RenderType" = "Transparent"
            "IgnoreProjector" = "True"
            "Queue" = "Transparent"
        }
        Blend SrcAlpha OneMinusSrcAlpha

        SubShader
        {
            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.05
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG       
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.1
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG  
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.15
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.2
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.25
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.3
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.35
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.4
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.45
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.5
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.55
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.6
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.65
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.7
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.75
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.8
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.85
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.9
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 0.95
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }

            Pass
            {
                CGPROGRAM
                #define FURSTEP 1.0
                #include "furInclude.cginc"
                #pragma vertex vert
                #pragma fragment frag
                ENDCG      
            }
        }
    }
}
