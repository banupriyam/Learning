//
//  DataReciverViewController.swift
//  Learning
//
//  Created by Banu on 30/03/21.
//

import UIKit

class DataReceiverViewController: UIViewController {

    @IBOutlet weak var dataReceiverLable: UILabel!
    
    var receivedData = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dataReceiverLable.text = receivedData
    }
    

    

}
