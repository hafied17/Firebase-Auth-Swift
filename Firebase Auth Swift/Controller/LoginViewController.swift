//
//  LoginViewController.swift
//  Firebase Auth Swift
//
//  Created by hafied Khalifatul ash.shiddiqi on 23/11/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        if tfEmail.text?.isEmpty ?? true {
            showAlert(msg: "Email tidak boleh kosong")
        } else if tfPassword.text?.isEmpty ?? true {
            showAlert(msg: "Password tidak boleh kosong")
        } else {
            Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) {
                (responseLogin, error) in
                if let error = error as? NSError {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .invalidEmail:
                        self.showAlert(msg: "Email tidak terdaftar")
                        
                        break
                        
                    case .missingEmail:
                        self.showAlert(msg: "email ksoong")
                        
                        break
                    
                    case .wrongPassword:
                        self.showAlert(msg: "Password salah")
                        
                        break
                        
                    default:
                        print("error sign in " + error.localizedDescription)
                    }
                } else {
                    self.toHome()
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
    func toHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController") as ViewController
        present(viewController, animated: true, completion: nil)
    }
}

