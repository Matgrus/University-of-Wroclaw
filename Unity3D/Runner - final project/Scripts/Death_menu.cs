using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Death_menu : MonoBehaviour
{
    public Text death_score_txt;

    public static bool end;

    private Image background;
    private float aa = 0;

    void Start()
    {
        end = false;
        Time.timeScale = 1;
        background = GetComponent<Image>();
        gameObject.SetActive(false);
    }

    void Update()
    {
        if (end)
        {
            death_score_txt.text = ((int)Score.score).ToString();
            Time.timeScale = 0;
            background.color = Color.Lerp(new Color(0, 0, 0, 0), Color.black, aa);
            aa += 0.01f;
        }
        
    }

    
    public void Start_game()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
        Floor.vel = 10;
        Score.score = 0;
    }
    

    public void Open_menu()
    {
        SceneManager.LoadScene("menu");
    }

}
