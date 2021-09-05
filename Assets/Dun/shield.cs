using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class shield : MonoBehaviour {
	private Vector4 position;

	private bool trigger =false;
	void OnTriggerEnter(Collider other)
	{
		Debug.Log("碰撞！");
		position =new Vector4(other.transform.position.x,other.transform.position.y,other.transform.position.z,0);
		GetComponent<Renderer>().material.SetVector("_Pos",position);
		_mTime =1f;
		trigger =true;
	}

	public float _mTime =1.0f;
	private void Update()
	{
		if(!trigger) return;

		if(_mTime<0)
		{
			trigger =false;
			_mTime=0.0f;
		}
		GetComponent<Renderer>().material.SetFloat("_mTime",_mTime);
		GetComponent<Renderer>().material.SetVector("_Pos",position);
		_mTime -=Time.deltaTime;
	}
}
