using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scanner : MonoBehaviour
{
    public Material mat;
    public float velocity = 5;//扫描速度
    private bool isScanning;
    private float dis;

    void Start()
    {
        //获取相机中的深度图
        Camera.main.depthTextureMode = DepthTextureMode.Depth;
    }

    void Update()
    {
        if(isScanning){
            dis += Time.deltaTime * this.velocity;
        }

        if(Input.GetKeyDown(KeyCode.C)){
            isScanning = true;
            dis = 0;
        }
    }

    void OnRenderImage(RenderTexture src, RenderTexture dst){
        //从cs里把扫描的距离传递到shader中去
        mat.SetFloat("_ScanDistance", dis);
        //通过材质mat将src渲染到dst上
        Graphics.Blit(src, dst, mat);
    }
}
