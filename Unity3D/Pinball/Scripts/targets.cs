using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class targets : MonoBehaviour
{
    public int id;
    public bool is_dropped = false;
    public static List<targets> drop_targets = new List<targets>();

    public int score_val_1 = 10;
    public int score_val_all = 50;

    private AudioSource sound;

    void Start()
    {
        drop_targets.Add(this);
        sound = GetComponent<AudioSource>();
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (!is_dropped)
        {
            score.score_res += score_val_1;
            transform.position += Vector3.right * 20.0f;
            is_dropped = true;
            sound.Play();

            bool reset_targets = true;
            foreach(targets x in drop_targets)
            {
                if (!x.is_dropped)
                {
                    reset_targets = false;
                }
            }

            if(reset_targets)
            {
                score.score_res += score_val_all;
                Invoke("reset_t", 0.5f);
            }
        }
    }

    void reset_t()
    {
        foreach(targets x in drop_targets)
        {
            x.transform.position += Vector3.left * 20.0f;
            x.is_dropped = false;
        }
    }
    
}
