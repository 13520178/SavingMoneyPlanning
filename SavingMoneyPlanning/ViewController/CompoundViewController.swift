//
//  CompoundViewController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 9/7/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

class CompoundViewController: UIViewController,GADBannerViewDelegate {

    @IBOutlet weak var heightFromInputToResult: NSLayoutConstraint!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var inputsView: UIView!
    @IBOutlet weak var calculateButtonView: UIView!
    @IBOutlet weak var resultAndShowMoreView: UIView!
    
    @IBOutlet weak var principalTextfield: UITextField!
    
    @IBOutlet weak var interestTextfield: UITextField!
    
    @IBOutlet weak var compoundButton: UIButton!
    
    @IBOutlet weak var timeTextfield: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var compoundModel = CompoundInterestModel()
    
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return .default //.default for black style
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.layer.cornerRadius = 8
        resultView.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        resultView.layer.borderWidth = 1
        
        resultAndShowMoreView.layer.cornerRadius = 5
        

        
        compoundButton.layer.cornerRadius = 5
        compoundButton.layer.borderWidth = 0.5
        compoundButton.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        compoundButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.hideKeyboardWhenTappedAround()
        setUpUnpredictableToKeyboard()
        
        
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        //bannerView.adUnitID = "ca-app-pub-9626752563546060/4427218069"
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // ex
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        compoundButton.titleLabel?.text = Tools.defaultCompoundPeriod
        
        principalTextfield.addTarget(self, action: #selector(principalTextFieldDidChange), for: .editingChanged)
        
        interestTextfield.addTarget(self, action: #selector(interestTextFieldDidChange), for: .editingChanged)
        
       
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        UIView.animate(withDuration: 1, animations: {
            self.heightFromInputToResult.constant = 380
            
        })
    }
    
    
    @objc func principalTextFieldDidChange(_ textField: UITextField) {
        principalTextfield.text = Tools.fixCurrencyTextInTextfield(moneyStr: principalTextfield.text ?? "" )
    }
    
    
    
    @objc func interestTextFieldDidChange(_ textField: UITextField) {
        interestTextfield.text = Tools.fixCurrencyTextInTextfield(moneyStr: interestTextfield.text ?? "" )
    }
    
    func setUpUnpredictableToKeyboard() {
        principalTextfield.autocorrectionType = .no
        interestTextfield.autocorrectionType = .no
        timeTextfield.autocorrectionType = .no
       
    }
    @IBAction func compoundButtonPressed(_ sender: UIButton) {
        AlertController.showActionButton(in: self) { (index) in
            if index == 1 {
                self.compoundButton.setTitle(Tools.stringDaily, for: .normal)
            }else if index == 2 {
                self.compoundButton.setTitle(Tools.stringWeekly, for: .normal)
            }else if index == 3 {
                self.compoundButton.setTitle(Tools.stringMonthly, for: .normal)
            }else if index == 4 {
                self.compoundButton.setTitle(Tools.stringQuarterly, for: .normal)
            }else {
                self.compoundButton.setTitle(Tools.stringAnnually, for: .normal)
            }
        }
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        timeTextfield.text = ""
        interestTextfield.text = ""
        principalTextfield.text = ""
    }
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        guard var principal = principalTextfield.text,
            principal != "",
            var  interest = interestTextfield.text,
            interest != "",
            let time = timeTextfield.text,
            time != ""
        else {
            AlertController.showAlert(inController: self, tilte: NSLocalizedString("Error", comment: "error"), message: NSLocalizedString("pleaseFill", comment: "Please Fill"))
            return
        }
        
        principal = Tools.getMoneyFromTextFieldToUsing(ftString: principal)
        interest = Tools.getMoneyFromTextFieldToUsing(ftString: interest)
        
        principal = Tools.replaceDotOrComma(string: principal)
        interest = Tools.replaceDotOrComma(string: interest)
        
        let principalDouble:Double? = Double(Tools.replaceSpace(string: principal))
        let interestDouble:Double? = Double(Tools.replaceSpace(string: interest))
        let timeInt:Int? = Int(Tools.replaceSpace(string: time))
        
        if  let principalDouble = principalDouble,
            principalDouble >= 0,
            let interestDouble = interestDouble,
            interestDouble >= 0,
            let timeInt = timeInt,
            timeInt >= 1
        {
            
            compoundModel.pincipal = principalDouble
            compoundModel.interest = interestDouble
            compoundModel.time = timeInt
            if compoundButton.title(for: .normal) == Tools.stringDaily {
                compoundModel.compound = 365
            }else if compoundButton.title(for: .normal) == Tools.stringWeekly {
                compoundModel.compound = 48
            }else if compoundButton.title(for: .normal) == Tools.stringMonthly {
                compoundModel.compound = 12
            }else if compoundButton.title(for: .normal) == Tools.stringQuarterly {
                compoundModel.compound = 4
            }else {
                compoundModel.compound = 1
            }
            let result = compoundModel.calculate()
            let resultString = Tools.changeToCurrency(moneyStr: String((result*100).rounded()/100))!
            resultLabel.text = "$ \(resultString)"
           
        } else {
            AlertController.showAlert(inController: self, tilte: Tools.inputError, message: Tools.errorDuringDataEntry)
        }
        
        
    }
    
    @IBAction func showMoreDetailFormulaButtonPressed(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
}
