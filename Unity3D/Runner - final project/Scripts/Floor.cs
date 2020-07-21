using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Floor : MonoBehaviour
{
    public GameObject[] floor_elements;

    private Rigidbody[] children;

    private float pos_z;

    private bool speed;
    public static int vel = 10;

    void Start()
    {
        children = GetComponentsInChildren<Rigidbody>();
        InvokeRepeating("Speed_up", 10, 10);
    }

    void Update()
    {
        children = GetComponentsInChildren<Rigidbody>();
        foreach (Rigidbody child in children)
        {

            if (speed)
            {
                child.velocity = Vector3.back * vel;
            }

            if(child.position.z < -10)
            {
                Destroy(child.gameObject);
                pos_z = 0;
                foreach (Rigidbody child_2 in children)
                {
                    if(child_2.transform.position.z > pos_z)
                    {
                        pos_z = child_2.position.z;
                    }
                }
                int random_num = Random.Range(0, floor_elements.Length);
                GameObject new_floor;
                new_floor = Instantiate(floor_elements[random_num]) as GameObject;
                new_floor.transform.SetParent(this.transform);
                new_floor.transform.position = new Vector3(0, 0, pos_z + 8);
            }
        }
        speed = false;


    }

    private void Speed_up()
    {
        speed = true;
        vel += 2;
    }

}
