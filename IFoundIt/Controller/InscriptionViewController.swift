//
//  DeclarationViewController.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 26/03/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class InscriptionViewController: UIViewController {

    // MARK: - Oulets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    private func setupTextField() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @IBAction func unwindToInscription(segue: UIStoryboardSegue) { }
    
    @objc private func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func inscriptionButton() {
        createUser(email: emailTextField, password: passwordTextField)
    }
    
    @IBAction func connectionButton() {
        connectionUser(email: emailTextField, password: passwordTextField)
    }
    
    // MARK: - Function helpers
    
    // User connection
    private func connectionUser(email: UITextField, password: UITextField) {
        if email.text != "" && password.text != "" {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (authResult, error) in
                if error != nil {
                    self.presentAlert(message: "Il y a un prolème de connexion")
                    print(error.debugDescription)
                } else {
                    self.performSegue(withIdentifier: "segueToDeclaration", sender: self)
                }
            }
        } else {
            presentAlert(message: "Veuillez remplir tous les champs demandés")
        }
    }
    
    // Creating new User
    private func createUser(email: UITextField, password: UITextField) {
        if email.text != "" && password.text != "" {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    self.performSegue(withIdentifier: "segueToDeclaration", sender: self)
                }
            }
        } else {
            presentAlert(message: "Veuillez remplir tous les champs demandés")
        }
    }
    
    // Present alert error
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension
extension InscriptionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
