using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class bouncers : MonoBehaviour
{
    float strength = 75;
    public int score_val = 5;
    private AudioSource sound;

    private void Start()
    {
        sound = GetComponent<AudioSource>();
    }

    private void OnCollisionEnter(Collision collision)
    {
        collision.rigidbody.AddExplosionForce(strength, this.transform.position, 5.0f);
        sound.Play();
        score.score_res += score_val;
    }
}
