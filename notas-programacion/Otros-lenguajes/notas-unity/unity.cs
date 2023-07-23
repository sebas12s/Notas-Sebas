using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ControlJugador : MonoBehaviour
{
    // Start is called before the first frame update
    //dice que esto ocurrira antes que inicie el juego
    void Start()
    {
        
    }

    // Update is called once per frame
    //esto en cada frame cada momento 
    void Update()
    {
        transform.Traslate(0, 0, 1);    //el objeto transform en unity esta donde estan las cordenadads
                                        //Traslate es un metodo donde le decimos en que cordenadas queremos moverlo en este caso le dijimos que z y y 0 pero en z 1
    }
}