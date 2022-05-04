using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class PostEffectColorChange : MonoBehaviour
{
    public Shader shader;
    private Material mat;
    [Range(0.0f, 3.0f)]
    public float brightness = 1.0f;
    [Range(0.0f, 3.0f)]
    public float saturation = 1.0f;
    [Range(0.0f, 3.0f)]
    public float contrast = 1.0f;

    private bool isEnterBulletTime = false;

    void Start()
    {
        mat         = new Material(shader);
    }
    
    private void OnRenderImage(RenderTexture source, RenderTexture destination) {
        if (!isEnterBulletTime || mat == null)
        {
            Graphics.Blit(source, destination);
            return;
        }
        mat.SetFloat("_Brightness", brightness);
        mat.SetFloat("_Saturation", saturation);
        mat.SetFloat("_Contrast", contrast);
        Graphics.Blit(source, destination, mat);
    }
}
