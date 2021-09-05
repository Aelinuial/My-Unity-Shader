using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shooter : MonoBehaviour {

	public GameObject bullet;
	
	public Transform forward;
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.S))
		{
			//TODO:生成子弹
			GameObject go =GameObject.Instantiate(bullet) as GameObject;
			go.transform.position = forward.position;
			go.transform.rotation = forward.rotation;

		}
	}
}
