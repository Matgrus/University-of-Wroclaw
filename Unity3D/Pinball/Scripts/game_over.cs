using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class game_over : MonoBehaviour
{

    public Transform ball;
    private AudioSource sound;

    void Start()
    {
        sound = GetComponent<AudioSource>();
    }

    void Update()
    {
        if (Input.GetKey(KeyCode.R))
        {
            score.score_res = 0;
            targets.drop_targets.Clear();
            Time.timeScale = 1;
            SceneManager.LoadScene("SampleScene");
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        Time.timeScale = 0;
        over_txt.is_over = true;
        sound.Play();
    }

}
