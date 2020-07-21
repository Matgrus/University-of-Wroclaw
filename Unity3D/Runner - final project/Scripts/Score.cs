using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Score : MonoBehaviour
{
    public static float score = 0.0f;
    public Text score_txt;

    void Start()
    {
        
    }

    void Update()
    {
        score += Time.deltaTime;
        score_txt.text = "Score: " + ((int)score).ToString();
    }
}
