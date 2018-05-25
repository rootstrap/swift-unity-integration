using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

public class TestScript : MonoBehaviour {

    public Renderer renderer;
    public Animator animator;
	// Use this for initialization
	void Start () {
		animator.enabled = false;
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetMouseButtonDown(0)) {
			setAnimation(!animator.enabled);
		}
	}

	public void changeColor(string hexString) {
		Color c = new Color();
     	ColorUtility.TryParseHtmlString(hexString, out c);
     	if (GetComponent<Renderer>() != null) {
            renderer.material.color = c;
     		System.Console.WriteLine("Changed color to: " + hexString);
     	}
	}

	public void stopAnimating() {
		setAnimation(false);
	}

	[DllImport("__Internal")]
	static extern void appAnimatingModel(bool active);
	
	public void setAnimation(bool active) {
		animator.enabled = active;
		#if UNITY_IOS
			appAnimatingModel(active);
		#endif
	}
}
