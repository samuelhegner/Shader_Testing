using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UpdatePosition : MonoBehaviour
{
    public Renderer rend;

    public GameObject player;

    public float dist;
    public float maxDist;

    public float maxYVal = 10f;

    public float currentYVal;
    public float currentAVal;

    public float lerpSpeed;
    
    // Start is called before the first frame update
    void Start()
    {
        player = GameObject.Find("Player");
        rend.material.SetFloat("_YVal", maxYVal);
    }

    // Update is called once per frame
    void Update()
    {
        currentYVal = rend.material.GetFloat("_YVal");
        currentAVal = rend.material.GetFloat("_NewAlpha");
        dist = Vector3.Distance(transform.position, player.transform.position);

        if (dist <maxDist )
        {
            currentAVal = Mathf.Lerp(currentAVal, 1f, Time.deltaTime * lerpSpeed);
            currentYVal = Mathf.Lerp(currentYVal, 0, Time.deltaTime * lerpSpeed);
        }
        else
        {
            currentAVal = Mathf.Lerp(currentAVal, 0f, Time.deltaTime * lerpSpeed);
            currentYVal = Mathf.Lerp(currentYVal, maxYVal, Time.deltaTime * lerpSpeed);
        }
        
        rend.material.SetFloat("_YVal", currentYVal);
        rend.material.SetFloat("_NewAlpha", currentAVal);

    }
}
