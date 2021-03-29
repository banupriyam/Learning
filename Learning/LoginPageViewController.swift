//
//  LoginPageViewController.swift
//  Learning
//
//  Created by Banu on 26/03/21.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var eMailTextField: UITextField!
    
    @IBOutlet weak var passWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func logInButton(_ sender: Any) {
        guard let email = eMailTextField.text, let password = passWordTextField.text else {
            print("Enter both values")
            return
        }
        
        guard let url = URL(string: "https://systimanx.xyz/laravel-starter-kit/public/api/v1/auth/login") else {return}
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postData = "email=\(email)&password=\(password)&grant_type=password".data(using: .utf8)
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
                    if requestJson["status"] as! Int == 1 {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "ToWelcomeScreen", sender: nil)
                            
                        }
                        
                    } else if let messages = requestJson["message"] as? [String] {
                        var message = ""
                        for aValue in messages {
                            message.append(aValue)
                            message.append("\n")
                        }
                        self.showMessage(message)
                    } else if let message = requestJson["message"] as? String {
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
            }
            
        })
        
        webTask.resume()
    }
    
    
    
}

