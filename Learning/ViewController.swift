//
//  ViewController.swift
//  Learning
//
//  Created by Banu on 08/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension UIViewController {
    func showMessage(_ message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let doneAction = UIAlertAction(title: " Done", style: .default, handler: handler) 
            alert.addAction(doneAction)
            self.present(alert, animated: true)

        }
        
    }
    
}
