//
//  ViewController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/24/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

class InputViewController: UIViewController, UITextFieldDelegate, GADBannerViewDelegate {
    
    //MARK: - Outlet
    @IBOutlet weak var currencyUnitTextField: UITextField!
    @IBOutlet weak var amountAvailableTextField: UITextField!
    @IBOutlet weak var firstYearEarningTextField: UITextField!
    @IBOutlet weak var annualIncomeTextField: UITextField!
    @IBOutlet weak var percentOrNumSegment: UISegmentedControl!
    @IBOutlet weak var percentageForSavingTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var bankInterestTextField: UITextField!
    @IBOutlet weak var caculatorStackView: UIStackView!
    
    
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var avergaLabel: UILabel!
    //Declare variable
    var caculate = CaculateTheSavingMoney()
    var isPerformSegue:Bool = false
    var averages = [Average]()
    var averageNumber = Double()
    var backFromTotal = false
    var forReloadData = CaculateTheSavingMoney()
    
     let defaults = UserDefaults.standard
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    var firstNumber = Double()
    var secondNumber = Double ()
    var kiemTraSoLanNhapDau = 1
    var dau = 0
    var tinhMoi = false
    var stringForReset = ""
    var hasPutEqua = false
    @IBOutlet weak var label: UILabel!
    @IBAction func numbers(_ sender: UIButton)
    {
        hasPutEqua = false
        if tinhMoi {
            if (label.text?.contains("+"))! || (label.text?.contains("-"))! || (label.text?.contains("x"))! || (label.text?.contains("/"))! {
                label.text = label.text! + String(sender.tag-1)
                tinhMoi = false
            }else {
                firstNumber = 0
                secondNumber = 0
                kiemTraSoLanNhapDau = 1
                label.text = stringForReset + String(sender.tag-1)
                stringForReset = label.text!
            }
        }else
        {
            label.text = label.text! + String(sender.tag-1)
        }
    }
    
    @IBAction func dieMarth(_ sender: UIButton)
    {
        if kiemTraSoLanNhapDau == 1 {
            firstNumber = Double(label.text!)!
            if sender.tag == 12 {
                hasPutEqua = false
                label.text = "+"
                dau = 1
            }else if sender.tag == 13 {
                hasPutEqua = false
                label.text = "-"
                dau = 2
            }else if sender.tag == 14 {
                hasPutEqua = false
                label.text = "x"
                dau = 3
            }else if sender.tag == 15 {
                hasPutEqua = false
                label.text  = "/"
                dau = 4
            }else if sender.tag == 16 {
                if !hasPutEqua {
                    label.text = String(firstNumber)
                    hasPutEqua = true
                }
            }else if sender.tag == 11 {
                stringForReset = ""
                label.text = ""
                firstNumber = 0
                secondNumber = 0
            }
            kiemTraSoLanNhapDau = 2
        }else if kiemTraSoLanNhapDau != 1 {
            if sender.tag == 12 {
                label.text = "+"
                dau = 1
            }else if sender.tag == 13 {
                label.text = "-"
                dau = 2
            }else if sender.tag == 14 {
                label.text = "x"
                dau = 3
            }else if sender.tag == 15 {
                label.text  = "/"
                dau = 4
            }else if sender.tag == 16 {
                if !hasPutEqua {
                    let sc = label!.text!
                    stringForReset = ""
                    if sc.contains("+") || sc.contains("-") || sc.contains("x") || sc.contains("/") {
                        let index = sc.index(sc.startIndex, offsetBy: 1)
                        secondNumber = Double((String(sc[index...])))!
                    }else {
                        secondNumber = Double(sc)!
                    }
                    
                    if dau == 1 {
                        label.text = String(firstNumber + secondNumber)
                    }else if dau == 2 {
                        label.text = String(firstNumber - secondNumber)
                    }else if dau == 3 {
                        label.text = String(firstNumber * secondNumber)
                    }else if dau == 4 {
                        label.text = String(firstNumber / secondNumber)
                    }
                    firstNumber = Double(label.text!)!
                    tinhMoi = true
                    hasPutEqua = true
                }
            }else if sender.tag == 11 {
                stringForReset = ""
                label.text = ""
                firstNumber = 0
                secondNumber = 0
            }
        }
        
    }
    
    func setUpUnpredictableToKeyboard() {
        currencyUnitTextField.autocorrectionType = .no
        amountAvailableTextField.autocorrectionType = .no
        firstYearEarningTextField.autocorrectionType = .no
        annualIncomeTextField.autocorrectionType = .no
        percentageForSavingTextField.autocorrectionType = .no
        yearsTextField.autocorrectionType = .no
        bankInterestTextField.autocorrectionType = .no
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setUpUnpredictableToKeyboard()
        
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.adUnitID = "ca-app-pub-9626752563546060/6460736189"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        amountAvailableTextField.delegate = self
        firstYearEarningTextField.delegate = self
        
        if backFromTotal {
            currencyUnitTextField.text = caculate.currencyUnit
            amountAvailableTextField.text = String(caculate.amountAvailable)
            firstYearEarningTextField.text = String(caculate.moneySavingPerYear.firstYearEarning)
            annualIncomeTextField.text = String(caculate.moneySavingPerYear.annualIncomeIcreases)
            percentageForSavingTextField.text = String(caculate.moneySavingPerYear.percentOfIncomeForSaving)
            yearsTextField.text = String(caculate.moneySavingPerYear.years)
            bankInterestTextField.text = String(caculate.interest)
            if caculate.moneySavingPerYear.isPercent  {
                percentOrNumSegment.selectedSegmentIndex = 0
            }else {
                percentOrNumSegment.selectedSegmentIndex = 1
            }
            
        }
        caculate = CaculateTheSavingMoney()
        let fetchRequest: NSFetchRequest<Average> = Average.fetchRequest()
        
        do {
            let averages = try PersitenceService.context.fetch(fetchRequest)
            self.averages = averages
            if self.averages.count != 0 {
                var averageNumbers = [Double]()
                for aver in self.averages {
                    averageNumbers.append(aver.number)
                }
                forReloadData.moneySavingPerYear.firstYearEarning = defaults.double(forKey: "firstYearEarningDefaults")
                forReloadData.amountAvailable = defaults.double(forKey: "amountAvailableDefaults")
                forReloadData.currencyUnit = defaults.string(forKey: "currencyUnitDefaults") ?? ""
                forReloadData.interest = defaults.double(forKey: "bankInterestDefaults")
                forReloadData.moneySavingPerYear.years = defaults.integer(forKey: "yearDefaults")
                forReloadData.moneySavingPerYear.percentOfIncomeForSaving = defaults.double(forKey: "percentForSavingDefaults")
                forReloadData.moneySavingPerYear.isPercent = defaults.bool(forKey: "percentOrNumberDefaults")
                forReloadData.moneySavingPerYear.annualIncomeIcreases = defaults.double(forKey: "anualIcreaseDefaults")
               
                let sumArray = averageNumbers.reduce(0, +)
                let avgArrayValue = (sumArray / Double(averageNumbers.count)*100).rounded()/100
                 avergaLabel.text = "Average percentage savings : \(avgArrayValue)%"
                //
            }
            
        }catch {}
        

    }
    
    @IBAction func caculateResult(_ sender: UIButton) {
        guard let amountAvailable = amountAvailableTextField.text,
            amountAvailable != "",
            let firstYearEarning = firstYearEarningTextField.text,
            firstYearEarning != "",
            let annualIncomeIcreases = annualIncomeTextField.text,
            annualIncomeIcreases != "",
            let percentOfIncomeForSaving = percentageForSavingTextField.text,
            percentOfIncomeForSaving != "",
            let years = yearsTextField.text,
            years != "",
            var currencyUnitValue = currencyUnitTextField.text,
            let interest = bankInterestTextField.text,
            interest != ""
        else {
            AlertController.showAlert(inController: self, tilte: NSLocalizedString("Error", comment: "error"), message: NSLocalizedString("pleaseFill", comment: "Please Fill"))
            return
        }
        
        let firstYearEarningDouble:Double? = Double(Tools.replaceSpace(string: firstYearEarning))
        let annualIncomeIcreasesDbouble:Double? = Double(Tools.replaceSpace(string: annualIncomeIcreases))
        let percentOfIncomeForSavingDouble:Double? = Double(Tools.replaceSpace(string: percentOfIncomeForSaving))
        let yearsInt:Int? = Int(Tools.replaceSpace(string: years))
        let amountAvailableDouble:Double? = Double(Tools.replaceSpace(string: amountAvailable))
        let interestDouble:Double? = Double(Tools.replaceSpace(string: interest))
        
        //Format the unit currency again
        if currencyUnitValue == ""{
            currencyUnitValue = " "
        }
        
        
        if  let firstYearEarningDouble = firstYearEarningDouble,
            firstYearEarningDouble >= 0,
            let annualIncomeIcreasesDbouble = annualIncomeIcreasesDbouble,
            annualIncomeIcreasesDbouble >= 0,
            let percentOfIncomeForSavingDouble = percentOfIncomeForSavingDouble,
            percentOfIncomeForSavingDouble >= 0,
            let yearsInt = yearsInt,
            yearsInt >= 1,
            let amountAvailableDouble = amountAvailableDouble,
            amountAvailableDouble >= 0,
            let interestDouble = interestDouble,
            interestDouble >= 0
        {
            if percentOfIncomeForSavingDouble > 100  {
                AlertController.showAlert(inController: self, tilte: NSLocalizedString("Error", comment: "error"), message: NSLocalizedString("percentOfIncome", comment: "percent Of Income"))
                return
            }
            
            caculate.moneySavingPerYear.firstYearEarning = firstYearEarningDouble
            caculate.moneySavingPerYear.annualIncomeIcreases = annualIncomeIcreasesDbouble
            caculate.moneySavingPerYear.percentOfIncomeForSaving = percentOfIncomeForSavingDouble
            caculate.moneySavingPerYear.years = yearsInt
            caculate.amountAvailable = amountAvailableDouble
            caculate.interest = interestDouble
            caculate.currencyUnit = currencyUnitValue

            switch percentOrNumSegment.selectedSegmentIndex
            {
            case 0:
                caculate.moneySavingPerYear.isPercent = true
            case 1:
                caculate.moneySavingPerYear.isPercent = false
            default:
                break
            }
            caculate.moneyPerYear = caculate.caculate()
            isPerformSegue = true
            let average = Average(context: PersitenceService.context)
            average.number = percentOfIncomeForSavingDouble
            
            defaults.set(currencyUnitValue, forKey: "currencyUnitDefaults")
            defaults.set(annualIncomeIcreasesDbouble, forKey: "anualIcreaseDefaults")
            defaults.set(amountAvailableDouble, forKey: "amountAvailableDefaults")
            defaults.set(interestDouble, forKey: "bankInterestDefaults")
            defaults.set(firstYearEarningDouble, forKey: "firstYearEarningDefaults")
            defaults.set(percentOfIncomeForSavingDouble, forKey: "percentForSavingDefaults")
            defaults.set(caculate.moneySavingPerYear.isPercent, forKey: "percentOrNumberDefaults")
            defaults.set(yearsInt, forKey: "yearDefaults")

            PersitenceService.saveContext()
            averages.append(average)
        } else {
             AlertController.showAlert(inController: self, tilte: "Input Error", message: "There may be a few errors during data entry")
        }
      
    }
    
    
    @IBOutlet weak var showOrHideCaculatorButton: UIButton!
    @IBAction func showOrHideCaculator(_ sender: UIButton) {
        caculatorStackView.isHidden = !caculatorStackView.isHidden
        if !caculatorStackView.isHidden {
            showOrHideCaculatorButton.setTitle("Hide calculator", for: .normal)
        }else {
            showOrHideCaculatorButton.setTitle("Show calculator", for: .normal)
        }
    }
    
    @IBAction func recentRecord(_ sender: UIButton) {

        if defaults.integer(forKey: "yearDefaults") != 0 {
            currencyUnitTextField.text = defaults.string(forKey: "currencyUnitDefaults")
            amountAvailableTextField.text = String(defaults.double(forKey: "amountAvailableDefaults"))
            firstYearEarningTextField.text = String(defaults.double(forKey: "firstYearEarningDefaults"))
            annualIncomeTextField.text = String(defaults.double(forKey: "anualIcreaseDefaults"))
            percentageForSavingTextField.text = String(defaults.double(forKey: "percentForSavingDefaults"))
            yearsTextField.text = String(defaults.integer(forKey: "yearDefaults"))
            bankInterestTextField.text = String(defaults.double(forKey: "bankInterestDefaults"))
            if defaults.bool(forKey: "percentOrNumberDefaults") {
                percentOrNumSegment.selectedSegmentIndex = 0
            }else {
                percentOrNumSegment.selectedSegmentIndex = 1
            }
        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isPerformSegue == true {
            if segue.identifier == "InputViewController" {
                if let destination = segue.destination as? TotalResultViewController {
                    destination.caculate = CaculateTheSavingMoney()
                    destination.caculate = caculate
                }
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isPerformSegue
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


