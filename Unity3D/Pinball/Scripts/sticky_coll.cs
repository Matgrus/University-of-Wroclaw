using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class sticky_coll : MonoBehaviour
{

    private AudioSource sound1;
    private AudioSource sound2;
    private AudioSource[] sounds;

    public Transform wall2;
    private Vector3 wall2_pos;

    private void Start()
    {
        sounds = GetComponents<AudioSource>();
        sound1 = sounds[0];
        sound2 = sounds[1];
        wall2_pos = wall2.position;
    }

    private void OnCollisionEnter(Collision collision)
    {
        collision.rigidbody.position = new Vector3(-4.8f, collision.rigidbody.position.y, 3.0f);
        collision.rigidbody.GetComponent<Renderer>().enabled = false;
        wall2.position += Vector3.right * 30f;
        score.score_res += 250;
        sound1.Play();
        collision.rigidbody.constraints = RigidbodyConstraints.FreezePositionX | RigidbodyConstraints.FreezePositionY | RigidbodyConstraints.FreezePositionZ;
        StartCoroutine(bounce_back(collision, wall2, 2.0f));
    }

    IEnumerator bounce_back(Collision x, Transform w, float delayTime)
    {
        yield return new WaitForSeconds(delayTime);
        sound2.Play();
        x.rigidbody.GetComponent<Renderer>().enabled = true;
        x.rigidbody.position = new Vector3(-4.8f, x.rigidbody.position.y, 2.0f);
        x.rigidbody.constraints = RigidbodyConstraints.None;
        x.rigidbody.constraints = RigidbodyConstraints.FreezePositionY;
        x.rigidbody.velocity = new Vector3(30, 0, -30);
        w.position = wall2_pos;

    }
}
