//
//  ViewController+extensions.swift
//  ChatBot
//
//  Created by Fabian Labra on 06/04/23.
//

import UIKit

extension UIViewController {
    
    // cierra keyboard al tap fuera de el
    func closeKeyBoard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
//    Loader
    func loader() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "Cargando...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        self.present(alert, animated: true)
        return alert
    }
    
    // Stop loader
    func stopLoader(loader: UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
}
