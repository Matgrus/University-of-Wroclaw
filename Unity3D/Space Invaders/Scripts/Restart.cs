using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Restart : MonoBehaviour
{

    void Update()
    {
        if (Input.GetKey(KeyCode.R))
        {
            Lost.game_over = false;
            Time.timeScale = 1;
            SceneManager.LoadScene("SampleScene");
        }
    }
}
