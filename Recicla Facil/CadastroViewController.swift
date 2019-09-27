//
//  CadastroViewController.swift
//  Recicla Facil
//
//  Created by aluno on 25/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    var usuarios:[Usuario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func Cadastrar(_ sender: Any) {
        if(VerificaCadastro()){
        var novoUser:Usuario = Usuario.init(id:"user",primeiroAcesso: true, email: self.usuario.text!, senha: self.senha.text!)
            
        //    if(UsuariosGerados()){ //usuarios existentes
               // usuarios = UserDefaults.standard.object(forKey: "usuarios") as! [Usuario]
                usuarios.append(novoUser)
            UserDefaults.standard.set(usuarios, forKey: "usuarios")
                mostrarMesagem(titulo: "Mensagem", mensagem: "Usuario criado com sucesso!")
            }
            /*else{ //nenhum usuario
                usuarios.append(novoUser)
                UserDefaults.standard.set(usuarios,forKey: "usuarios")
                mostrarMesagem(titulo: "Mensagem", mensagem: "Usuario criado com sucesso!")
            }*/
        }
    
    
    
    func VerificaCadastro() -> Bool{
        if(usuario.text!.isEmpty || email.text!.isEmpty || senha.text!.isEmpty )
     {
       mostrarMesagem(titulo: "Aviso", mensagem: "Os campos não foram preenchidos!")
        return false
        }
     else{
        
        return true
        }
        
    }
    
    func UsuariosGerados() -> Bool {
        var usuariosDB:[Usuario]  = UserDefaults.standard.object(forKey:"usuarios") as! [Usuario]
        if(usuariosDB == nil || usuariosDB.isEmpty ){
            return false
        }
        
        return true
    }
    
    
    func mostrarMesagem(titulo:String,mensagem:String){
        let alertController = UIAlertController(title: titulo, message:
            mensagem, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
