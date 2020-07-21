using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Lost : MonoBehaviour
{
    public static bool game_over = false;
    private Text game_over_txt;

    public AudioClip clip;
    AudioSource sound;
    private bool played = false;

    void Start()
    {
        game_over_txt = GetComponent<Text>();
        game_over_txt.enabled = false;
        sound = GetComponent<AudioSource>();
    }

    void Update()
    {
        if (game_over)
        {
            if (!played)
            {
                sound.PlayOneShot(clip);
                played = true;
            }
            Time.timeScale = 0;
            game_over_txt.enabled = true;
        }
    }
}
