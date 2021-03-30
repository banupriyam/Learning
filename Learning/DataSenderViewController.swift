//
//  DataSenderViewController.swift
//  Learning
//
//  Created by Banu on 30/03/21.
//

import UIKit

class DataSenderViewController: UIViewController {

    @IBOutlet weak var textToSendTextField: UITextField!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dataReceiverViewController = segue.destination as! DataReceiverViewController
        dataReceiverViewController.receivedData = textToSendTextField.text!
    }
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    

}
