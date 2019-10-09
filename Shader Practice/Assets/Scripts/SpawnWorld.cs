using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnWorld : MonoBehaviour
{
    public int gridSize;

    public GameObject prefab;
    
    
    void Start()
    {
        SpawnGrid();
    }

    void Update()
    {
        
    }

    void SpawnGrid()
    {
        for (int i = 0; i < gridSize; i++)
        {
            for (int j = 0; j < gridSize; j++)
            {
                Vector3 pos = new Vector3(i, 0, j);
                Instantiate(prefab, pos, Quaternion.identity, transform);
            }
        }
    }
}
