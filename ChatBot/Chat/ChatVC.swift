//
//  ChatVC.swift
//  ChatBot
//
//  Created by Fabian Labra on 06/04/23.
//

import UIKit

class ChatVC: UIViewController {
    
    // outlets
    @IBOutlet weak var chatInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // constrainst outlets
    @IBOutlet weak var stackBottomConstraint: NSLayoutConstraint!
    
    var arrchat: [ChatStruct] = []
    var loader: UIAlertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        notoficationKey()
    }
    
    func viewConfig() {
        title = "Chat"
        chatInput.adjustsFontSizeToFitWidth = false
        chatInput.minimumFontSize = 12
        closeKeyBoard()
        tableConfig()
    }
    
    func tableConfig() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "chatCell")
        tableView.register(UINib(nibName: "ChatCellUser", bundle: nil), forCellReuseIdentifier: "chatCellUser")
    }
    
    func notoficationKey() {
    // Notifications for when the keyboard opens/closes
           NotificationCenter.default.addObserver(
               self,
               selector: #selector(self.keyboardWillShow),
               name: UIResponder.keyboardWillShowNotification,
               object: nil)

           NotificationCenter.default.addObserver(
               self,
               selector: #selector(self.keyboardWillHide),
               name: UIResponder.keyboardWillHideNotification,
               object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
           // Move the view only when the usernameTextField or the passwordTextField are being edited
           if chatInput.isEditing {
               moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.stackBottomConstraint, keyboardWillShow: true)
           }
       }
       
       @objc func keyboardWillHide(_ notification: NSNotification) {
           moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.stackBottomConstraint, keyboardWillShow: false)
       }
       
       func moveViewWithKeyboard(notification: NSNotification, viewBottomConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
           // Keyboard's size
           guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
           let keyboardHeight = keyboardSize.height
           
           // Keyboard's animation duration
           let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
           
           // Keyboard's animation curve
           let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
           
           // Change the constant
           if keyboardWillShow {
               let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0) // Check if safe area exists
               let bottomConstant: CGFloat = 20
               viewBottomConstraint.constant = keyboardHeight + (safeAreaExists ? 0 : bottomConstant)
           }else {
               viewBottomConstraint.constant = 20
           }
           
           // Animate the view the same way the keyboard animates
           let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
               // Update Constraints
               self?.view.layoutIfNeeded()
           }
           
           // Perform the animation
           animator.startAnimation()
       }
    

    @IBAction func sendActBtn(_ sender: Any) {
        let newTxt: ChatStruct = ChatStruct(chat: chatInput.text!,type: "user")
        // Cerrar el teclado
        chatInput.endEditing(true)
        arrchat.append(newTxt)
        getChat(msj: chatInput.text!)
        chatInput.text! = ""
        
        tableView.reloadData()
        let lastIndex = IndexPath(row: self.arrchat.count - 1, section: 0)
        self.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        loader = loader()
    }
}


extension ChatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrchat.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if arrchat[indexPath.row].type! == "openai" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
            cell.chatLabel.text = arrchat[indexPath.row].chat!
                .trimmingCharacters(in: .whitespacesAndNewlines)
            cell.rightConst.constant = 100
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatCellUser", for: indexPath) as! ChatCellUser
            cell.leftConst.constant = 100
            cell.labelUser.text = arrchat[indexPath.row].chat!

            return cell

        }
        
    }
    
    
}


// MARK: Network
extension ChatVC {
    
    func getChat(msj: String) {
        print("Texto: ",msj)
        ChatService.shared.sendQuest(msj: msj) {
            res in
            
            let choices = res.choices
            let obj: ChatStruct = ChatStruct(chat: choices![0].text, type: "openai")
            self.arrchat.append(obj)
            self.tableView.reloadData()
            self.stopLoader(loader: self.loader)
            // Hacer scroll hacia abajo hasta la última fila de la tabla
            let lastIndex = IndexPath(row: self.arrchat.count - 1, section: 0)
            self.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)

        } failure: { error in
            print("error: ", error)
        }
        
    }
}
