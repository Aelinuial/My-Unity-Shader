using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenShoot : MonoBehaviour {

	private Camera m_camera;
	// Use this for initialization
	public GameObject bullet;
	void Start () {
		m_camera =GetComponent<Camera>();
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetMouseButtonDown(0))
		{
			Vector3 pos = m_camera.ScreenToWorldPoint(new Vector3(Input.mousePosition.x,Input.mousePosition.y,1));
			GameObject go =GameObject.Instantiate(bullet) as GameObject;
			go.transform.position = pos;
			go.transform.rotation = Quaternion.LookRotation(pos -m_camera.transform.position);
			//go.transform.rotation = forward.rotation;
		}
	}
}
