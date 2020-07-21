using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player_collision : MonoBehaviour
{
    public GameObject death_menu;

    public GameObject cam;
    private AudioSource cam_sound;

    void Start()
    {
        cam_sound = cam.GetComponent<AudioSource>();
    }

    void Update()
    {
        
    }

    private void OnCollisionEnter(Collision collision)
    { 
        if (Score.score > PlayerPrefs.GetFloat("Highscore"))
        {
            PlayerPrefs.SetFloat("Highscore", Score.score);
        }
        cam_sound.enabled = false;
        death_menu.SetActive(true);
        Death_menu.end = true;
        //Time.timeScale = 0;
    }

}
