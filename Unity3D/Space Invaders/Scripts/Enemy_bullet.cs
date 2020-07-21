using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy_bullet : MonoBehaviour
{
    private Transform bullet;

    void Start()
    {
        bullet = GetComponent<Transform>();
    }

    void FixedUpdate()
    {
        bullet.position += Vector3.right * 0.25f;
        if (bullet.position.x > 10)
        {
            Destroy(gameObject);
        }
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            Destroy(gameObject);
            Destroy(other.gameObject);
            Lost.game_over = true;
        }
    }
}
