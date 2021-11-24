//
//  RegisterViewController.swift
//  Firebase Auth Swift
//
//  Created by hafied Khalifatul ash.shiddiqi on 23/11/21.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var tfConfirmationPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        if tfEmail.text?.isEmpty ?? true {
            showAlert(msg: "Email tidak boleh kosong")
        } else if tfPassword.text?.isEmpty ?? true {
            showAlert(msg: "Password tidak boleh kosong")
        } else if tfConfirmationPassword.text?.isEmpty ?? true {
            showAlert(msg: "Confirmation password tidak boleh kosong")
        } else if tfPassword.text?.count ?? 0 < 6 {
            showAlert(msg: "Password minimal 6 karakter")
        } else if tfPassword.text != tfConfirmationPassword.text {
            showAlert(msg: "Password tidak sama")
        } else {
            Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPassword.text!) {
                (responseSignUp, error) in
                if let error = error as NSError? {
                    switch (AuthErrorCode(rawValue: error.code)) {
                    case .operationNotAllowed:self.showAlert(msg: "permission internet tidak ada")
                        break
                    case .weakPassword :
                        self.showAlert(msg: "password lemah")
                        break
                    case .emailAlreadyInUse :
                        self.showAlert(msg: "Email sudah ada")
                        break
                    case .invalidEmail :
                        self.showAlert(msg: "email tidak valid")
                        break
                    default:
                        print("error sign up " + error.localizedDescription)
                    }
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func showAlert (msg: String) {
        let alert = UIAlertController(title: "Information", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Oke", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
