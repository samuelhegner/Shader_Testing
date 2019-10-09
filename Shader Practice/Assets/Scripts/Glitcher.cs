using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Glitcher : MonoBehaviour
{
    [SerializeField] private Renderer renderer;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        renderer.material.SetFloat("_RandomVal", Random.Range(0.0f, 0.1f));
    }
}
