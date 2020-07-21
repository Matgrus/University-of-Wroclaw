using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class triangles : MonoBehaviour
{
    float strength = 250;
    private AudioSource sound;

    void Start()
    {
        sound = GetComponent<AudioSource>();
    }

    private void OnCollisionEnter(Collision collision)
    {
        if(collision.rigidbody.position.x < 0)
        {
            collision.rigidbody.AddExplosionForce(strength, new Vector3(collision.transform.position.x - 0.15f, collision.transform.position.y, collision.transform.position.z -0.15f), 5);
        }
        if (collision.rigidbody.position.x > 0)
        {
            collision.rigidbody.AddExplosionForce(strength, new Vector3(collision.transform.position.x + 0.15f, collision.transform.position.y, collision.transform.position.z - 0.15f), 5);
        }
        sound.Play();
    }
}
