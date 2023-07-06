//
//  ViewController.swift
//  ChatBot
//
//  Created by Fabian Labra on 06/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfig()
        goToChat()
    }
    
    func viewConfig(){
        title = "Bienvenido"
    }
    
    func goToChat() {
        let sb = UIStoryboard(name: "ChatSB", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "chatSB")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

