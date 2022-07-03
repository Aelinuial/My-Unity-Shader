using System.Collections;
using System.IO;
using UnityEngine;
using UnityEditor;

//计算模型平滑后的法线，存入顶点色通道
public class SetNormalSmooth : EditorWindow
{
    [MenuItem("Assets/平滑法线写入顶点色", false, 1)]
    static void SetNormalSmoothIntoVertexColor(){
        UnityEngine.Object[] gameObjects = Selection.objects;
        string[] strs = Selection.assetGUIDs;

        if(gameObjects.Length > 0){
            int objNum = gameObjects.Length;
            for(int i = 0; i < objNum; i++){
                string newMeshName = gameObjects[i].name;
                string assetPath = AssetDatabase.GUIDToAssetPath(strs[i]);
                string materialFolder = Path.GetDirectoryName(assetPath);
            
                Object[] assets = AssetDatabase.LoadAllAssetsAtPath(assetPath);
                foreach(Object item in assets){
                    if(typeof(Mesh) == item?.GetType()){
                        Debug.Log("需要平滑法线的Mesh：" + item);
                        Mesh mesh = item as Mesh;
                        
                        Vector3[] meshNormals = new Vector3[mesh.normals.Length];
                        for(int j = 0; j < meshNormals.Length; j++){
                            Vector3 normal = new Vector3(0, 0, 0);
                            for(int k = 0; k < meshNormals.Length; k++){
                                if(mesh.vertices[k] == mesh.vertices[j]){
                                    normal += mesh.vertices[k];
                                }
                            }
                            normal.Normalize();
                            meshNormals[j] = normal;
                        }

                        //构建模型空间到切线空间的转换矩阵
                        ArrayList OtoTMatrixs = new ArrayList();
                        for(int j = 0; j < mesh.normals.Length; j++){
                            Vector3[] OtoTMatrix = new Vector3[3];
                            OtoTMatrix[0] = new Vector3(mesh.tangents[j].x, mesh.tangents[j].y, mesh.tangents[j].z);
                            OtoTMatrix[1] = Vector3.Cross(mesh.normals[j], OtoTMatrix[0]);
                            OtoTMatrix[1] = new Vector3(OtoTMatrix[1].x * mesh.tangents[j].w, OtoTMatrix[1].y * mesh.tangents[j].w, OtoTMatrix[1].z * mesh.tangents[j].w);
                            OtoTMatrix[2] = mesh.normals[j];
                            OtoTMatrixs.Add(OtoTMatrix);
                        }

                        for(int j = 0; j < mesh.normals.Length; j++){
                            Vector3 tNormal;
                            tNormal = Vector3.zero;
                            tNormal.x = Vector3.Dot(((Vector3[])OtoTMatrixs[j])[0], meshNormals[j]);
                            tNormal.y = Vector3.Dot(((Vector3[])OtoTMatrixs[j])[1], meshNormals[j]);
                            tNormal.z = Vector3.Dot(((Vector3[])OtoTMatrixs[j])[2], meshNormals[j]);
                            meshNormals[j] = tNormal;
                        }

                        Color[] meshColors = new Color[mesh.colors.Length];
                        for (int j = 0; j < meshColors.Length; j++)
                        {
                            meshColors[j].r = meshNormals[j].x * 0.5f + 0.5f;
                            meshColors[j].g = meshNormals[j].y * 0.5f + 0.5f;
                            meshColors[j].b = meshNormals[j].z * 0.5f + 0.5f;
                            meshColors[j].a = mesh.colors[j].a ;
                            Debug.LogWarning(meshColors[j]);
                        }

                        Mesh newMesh = new Mesh();
                        newMesh.vertices = mesh.vertices;
                        newMesh.triangles = mesh.triangles;
                        newMesh.normals = mesh.normals;
                        newMesh.tangents = mesh.tangents;
                        newMesh.uv = mesh.uv;
                        newMesh.uv2 = mesh.uv2;
                        newMesh.uv3 = mesh.uv3;
                        newMesh.uv4 = mesh.uv4;
                        newMesh.uv5 = mesh.uv5;
                        newMesh.uv6 = mesh.uv6;
                        newMesh.uv7 = mesh.uv7;
                        newMesh.uv8 = mesh.uv8;
                        //将新模型的颜色赋值为计算好的颜色
                        newMesh.colors = meshColors;
                        newMesh.colors32 = mesh.colors32;
                        newMesh.bounds = mesh.bounds;
                        newMesh.indexFormat = mesh.indexFormat;
                        newMesh.bindposes = mesh.bindposes;
                        newMesh.boneWeights = mesh.boneWeights;
                        //将新mesh保存为.asset文件
                        AssetDatabase.CreateAsset(newMesh, materialFolder + "/new_cube.asset");
                        AssetDatabase.SaveAssets();
                        Debug.Log("Done");
                    }
                }
            }
        }
    }
}
