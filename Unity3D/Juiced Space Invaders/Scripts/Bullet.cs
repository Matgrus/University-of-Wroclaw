using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bullet : MonoBehaviour
{
    private Transform bullet;
    private AudioSource sound;

    public GameObject effect;

    void Start()
    {
        bullet = GetComponent<Transform>();
        sound = GetComponent<AudioSource>();
    }

    void FixedUpdate()
    {
        bullet.position += Vector3.left * 0.25f;
        if(bullet.position.x < -25)
        {
            Destroy(gameObject);
        }
    }    
    private void OnTriggerEnter(Collider other)
    {
        if(other.tag == "enemy")
        {
            sound.Play();
            //Destroy(gameObject);
            effect = Instantiate(effect, other.transform.position, Quaternion.identity);
            Destroy(effect, 2.0f);
            bullet.position = new Vector3(bullet.position[0], bullet.position[1], 40.0f);
            Destroy(other.gameObject);
        }
    }
}
