//
//  DeclarationViewController.swift
//  IFoundIt
//
//  Created by AMIMOBILE on 26/03/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Speech


class DeclarationViewController: UIViewController, SFSpeechRecognizerDelegate {

    // MARK: - Vars, Lets
    
    private var datePicker: UIDatePicker?
    private let imagePicker = UIImagePickerController()
    private let objectService = ObjectService(databaseRef: Database.database().reference(), storageRef: Storage.storage().reference())

    var audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "fr-FR"))
    let request =  SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var codePostalTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var objectImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codePostalTextField.delegate = self
        imagePicker.delegate = self
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(chooseDate(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        dateTextField.inputView = datePicker
    }
    
    // MARK: - Methods
    
    // Saving speech
    @IBAction func speechButton() {
        if isRecording == true {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            recognitionTask?.cancel()
            isRecording = false
        } else {
            self.recognizeSpeech()
            isRecording = true
        }
    }
    
    @IBAction func insertImageButton() {
        openSourceImage()
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // Using DatePicker for presenting date
    @objc func chooseDate(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func validationButton() {
        saveObject()
    }
    
    private func recognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1023, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch  {
            print("can't start audio")
            // present Alert
        }
     
        guard let myRecognizer = SFSpeechRecognizer() else { return }
        if !myRecognizer.isAvailable { return }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                let bestString = result.bestTranscription.formattedString
                self.descriptionTextView.text = bestString
            } else {
                print("Can't record")
                // present Alert
            }
        })
    }
    
    // save Object in Firebase
    func saveObject() {
        objectService.saveObject(objectName: nameTextField.text ?? "", objectCodePostal: codePostalTextField.text ?? "", objectDate: dateTextField.text ?? "", objectDescription: descriptionTextView.text ?? "", objectImageView: objectImageView)
        self.performSegue(withIdentifier: "segueToSuccess", sender: self)
    }
    
    // selecting Source of Photos
    private func openSourceImage() {
        let alert = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { _ in
            self.openLibrary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Using Library for selecting photos
    func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Present Alert Error
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


//MARK: - Extension
extension DeclarationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Accepting only numbers characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            let allowedCharacters = "0123456789"
            let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharacterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: typedCharacterSet)
        } else {
            return false
        }
    }
}

// Number of charracter < 80
extension DeclarationViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 80
    }
}

// Choosing image from Library
extension DeclarationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        objectImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
