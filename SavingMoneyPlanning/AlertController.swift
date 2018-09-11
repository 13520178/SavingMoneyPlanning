//
//  AlertController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/29/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit

class AlertController {
    static func showAlert(inController:UIViewController, tilte:String, message:String) {
        let alert = UIAlertController(title: tilte, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inController.present(alert, animated: true, completion: nil)
    }
    static func showTextField(inController:UIViewController, tilte:String, message:String) {
        let alert = UIAlertController(title: tilte, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "Some default text"
        }
        let action = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
        })
        alert.addAction(action)
        inController.present(alert, animated: true, completion: nil)
    }
}

