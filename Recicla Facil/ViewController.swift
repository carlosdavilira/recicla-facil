//
//  ViewController.swift
//  Recicla Facil
//
//  Created by aluno on 11/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   //Esses dois dados vem da tela login
    var login:String = "Exemplo"
    var email:String = "exemplo@gmail.com"
    var window: UIWindow?
    var acesso = Acesso.init()
    
    @IBOutlet weak var labelLogin: UITextField!
    @IBOutlet weak var labelSenha: UITextField!
    
    
    @IBAction func ComTutorial(_ sender: Any) {
        
        // -3.738000, -38.519733
        
        if(labelLogin.text == "registrado"){
              performSegue(withIdentifier: "semTutorial", sender: nil)
        }
        else if(labelLogin.text == "naoregistrado"){
              performSegue(withIdentifier: "comTutorial", sender: nil)
        }
        
    }
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //text
        //test Rejane -
        //Marcelo
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
      
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}

