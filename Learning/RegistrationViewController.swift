//
//  RegistrationViewController.swift
//  Learning
//
//  Created by Banu on 29/03/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cmsTypeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        guard let name = nameTextField.text, let email = eMailTextField.text, let password = passwordTextField.text else {
            print("Enter all values")
            return
        }
        
        guard let url = URL(string: "https://systimanx.xyz/laravel-starter-kit/public/api/v1/auth/register") else {return}
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "name=\(name)&email=\(email)&password=\(password)&cmstype=1".data(using: .utf8)
        request.httpBody = postData
        let webTask = session.dataTask(with: request, completionHandler: {data, response, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            guard let serverData = data else {
                print("server data error")
                return
            }
            do {
                if let requestJson = try JSONSerialization.jsonObject(with: serverData, options: .mutableContainers) as? [String: Any]{
                    print("Response: \(requestJson)")
                    if let messages = requestJson["message"] as? [String] {
                        var message = ""
                        for aValue in messages {
                            message.append(aValue)
                            message.append("\n")
                        }
                        self.showMessage(message)
                    }
                    if let message = requestJson["message"] as? String {
                        print(message)
                        self.showMessage(message) { (action) in
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } catch let responseError {
                print("Serialisation in error in creating response body: \(responseError.localizedDescription)")
                let message = String(bytes: serverData, encoding: .ascii)
                print(message as Any)
                self.showMessage(message ?? "")
                
            }
        })
        webTask.resume()
    }
    
    func activateUser() {
        guard let email = eMailTextField.text else {
            return
        }
        guard let url = URL(string: "https://systimanx.xyz/laravel-starter-kit/public/api/v1/auth/activate") else {return}
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "email=\(email)&code=1".data(using: .utf8)
        request.httpBody = postData
        let webTask = session.dataTask(with: request, completionHandler: {data, response, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            guard let serverData = data else {
                print("server data error")
                return
            }
            do {
                if let requestJson = try JSONSerialization.jsonObject(with: serverData, options: .mutableContainers) as? [String: Any]{
                    print("Response: \(requestJson)")
                    if let messages = requestJson["message"] as? [String] {
                        var message = ""
                        for aValue in messages {
                            message.append(aValue)
                            message.append("\n")
                        }
                        self.showMessage(message)
                    }
                    if let message = requestJson["message"] as? String {
                        self.showMessage(message) { (action) in
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } catch let responseError {
                print("Serialisation in error in creating response body: \(responseError.localizedDescription)")
                let message = String(bytes: serverData, encoding: .ascii)
                print(message as Any)
                self.showMessage(message ?? "")
                
            }
        })
        webTask.resume()
        
    }
    
    
    
}
