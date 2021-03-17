//
//  ViewAnimationViewController.swift
//  Learning
//
//  Created by Banu on 17/03/21.
//

import UIKit

class ViewAnimationViewController: UIViewController {
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func withoutAnimationAction(_ sender: Any) {
        imageLeadingConstraint.constant = 20
    }
    @IBAction func withAnimationAction(_ sender: Any) {
        imageLeadingConstraint.constant = 200
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
}
