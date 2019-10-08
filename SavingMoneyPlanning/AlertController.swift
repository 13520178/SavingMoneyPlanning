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
    
    static func showActionButton(in vc:UIViewController, completion: @escaping ( _ actionType: Int)->Void)  {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: Tools.stringDaily, style: .default , handler:{ (UIAlertAction)in
            completion(1)
        }))
        
        alert.addAction(UIAlertAction(title: Tools.stringWeekly , style: .default , handler:{ (UIAlertAction)in
            completion(2)
        }))
        alert.addAction(UIAlertAction(title: Tools.stringMonthly, style: .default , handler:{ (UIAlertAction)in
            completion(3)
        }))
        alert.addAction(UIAlertAction(title: Tools.stringQuarterly, style: .default , handler:{ (UIAlertAction)in
            completion(4)
        }))
        alert.addAction(UIAlertAction(title: Tools.stringAnnually, style: .default , handler:{ (UIAlertAction)in
            completion(5)
        }))
        
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        vc.present(alert, animated: true)
    }
}

