
 using System.Collections.Generic;
 using UnityEditor;
 using UnityEngine;


public class TestWindow: EditorWindow
{
    List<int> testGO = new List<int>();

    [MenuItem("TestTool/TestWindow")]
    static void Init()
    {
        TestWindow testWindow = (TestWindow)EditorWindow.GetWindow(typeof(TestWindow), false, "TestWindow", true);
        testWindow.Show();
    }

    void OnGUI(){
        if(GUILayout.Button("添加进列表")){
            GameObject go = Selection.activeGameObject;
            int i = go.GetInstanceID();
            Debug.Log(i);
            testGO.Add(i);
        }

        if(GUILayout.Button("清空列表")){
            testGO = new List<int>();
        }

        if(GUILayout.Button("查找列表物体")){
            if(testGO.Count != 0){
                int i = testGO[0];
                GameObject go = EditorUtility.InstanceIDToObject(i) as GameObject;
                Selection.activeGameObject = go;
            }
        }

        if(GUILayout.Button("测试按钮")){
            GameObject go = Selection.activeGameObject;
            foreach (Transform child in go.transform)
            {
                Debug.Log("所有子物体名称:"+child.name);
            }
        }
    }
}