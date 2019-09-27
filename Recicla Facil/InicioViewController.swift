//
//  InicioViewController.swift
//  Recicla Facil
//
//  Created by aluno on 17/09/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

class InicioViewController: UIViewController {

    //Esses dois dados vem do UserDefaults
    var login:String = "Exemplo"
    var email:String = "exemplo@gmail.com"
    
    @IBOutlet weak var labelInicio: UILabel!
    @IBAction func IniciarFiltro(_ sender: Any) {
        //Aqui vem o prepare
        
    }
    var acessosUsuarios:[Usuario] = []
    
    
    func verificaPrimeiroAcesso(){
        let refListaUsuarios = UserDefaults.standard.array(forKey: "listaUsuarios")
        guard let listaUsuarios = refListaUsuarios else { return }
        if listaUsuarios.isEmpty {
            //primeiro acesso sem nenhum usuario
            var user: Usuario = Usuario.init(id:self.email,primeiroAcesso:true,email:"",senha:"")
            print("Dentro do salvar usuario")
        }
        for user in listaUsuarios {
            //Chamar o prepare
        }
        print("Dentro do salvar usuario")
    }
    
    func setaPrimeiroAcesso(){
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
