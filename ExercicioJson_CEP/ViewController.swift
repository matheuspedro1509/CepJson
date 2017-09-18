//
//  ViewController.swift
//  ExercicioJson_CEP
//
//  Created by Usuário Convidado on 15/09/17.
//  Copyright © 2017 Matheus Santana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txvCep: UITextField!
    @IBOutlet weak var txvRua: UITextField!
    @IBOutlet var txvBairro: UITextField!
    @IBOutlet weak var txvCidade: UITextField!
    @IBOutlet weak var txvUf: UITextField!
    
    
    
    
    
    
    var session: URLSession?
    
    @IBAction func buscar(_ sender: Any) {
        
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        
        let cep = "http://viacep.com.br/ws/" +  txvCep.text! + "/json/"
        
        let url = URL(string: cep)
        
        let task = session!.dataTask(with: url!){ (data, response, error) in
            
            let rua = self.retornarNomeRua(data: data!, campo: "logradouro")
            let cidade = self.retornarNomeRua(data: data!, campo: "localidade")
            let bairro = self.retornarNomeRua(data: data!, campo: "bairro")
            let estado = self.retornarNomeRua(data: data!, campo: "uf")
            DispatchQueue.main.async(execute: {
                self.txvRua.text = rua
                self.txvCidade.text = cidade
                self.txvBairro.text = bairro
                self.txvUf.text = estado
        
            })
        }
        task.resume()
    }
    
    func retornarNomeRua(data: Data, campo:String) -> String?{
        var resposta: String?=nil
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let nomeRua = json[campo] as? String{
                return nomeRua
            }
        }catch let error as NSError {
            return "Falha ao carregar :\(error.localizedDescription)"
        }
        return resposta
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

