using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class PostEffectOutline : MonoBehaviour
{
    public Shader shader;
    private Material mat;
    public float edge = 3.9f;
    public int lineWidth = 1;

    void Start(){
        mat = new Material(shader);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination) {
        if(mat != null){
            mat.SetFloat("_Edge", edge);
            mat.SetInt("_Width", lineWidth);
            Graphics.Blit(source, destination, mat);
        }
        else{
            Graphics.Blit(source, destination);
        }
    }
}
