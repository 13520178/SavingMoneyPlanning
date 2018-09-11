//
//  ViewController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/24/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit
import CoreData

class InputViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlet
    @IBOutlet weak var currencyUnitTextField: UITextField!
    @IBOutlet weak var amountAvailableTextField: UITextField!
    @IBOutlet weak var firstYearEarningTextField: UITextField!
    @IBOutlet weak var annualIncomeTextField: UITextField!
    @IBOutlet weak var percentOrNumSegment: UISegmentedControl!
    @IBOutlet weak var percentageForSavingTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var bankInterestTextField: UITextField!
    @IBOutlet weak var AmountOfMoneyToBeAchieve: UITextField!
    
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var avergaLabel: UILabel!
    //Declare variable
    var caculate = CaculateTheSavingMoney()
    var isPerformSegue:Bool = false
    var averages = [Average]()
    var averageNumber = Double()
    var backFromTotal = false
    var amountAvalable = Int()
    var firstEarning = Int()
    var forReloadData = CaculateTheSavingMoney()
    
    func setUpUnpredictableToKeyboard() {
        currencyUnitTextField.autocorrectionType = .no
        amountAvailableTextField.autocorrectionType = .no
        firstYearEarningTextField.autocorrectionType = .no
        annualIncomeTextField.autocorrectionType = .no
        percentageForSavingTextField.autocorrectionType = .no
        yearsTextField.autocorrectionType = .no
        bankInterestTextField.autocorrectionType = .no
        AmountOfMoneyToBeAchieve.autocorrectionType = .no
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setUpUnpredictableToKeyboard()
        
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
            firstEarning = Int(caculate.moneySavingPerYear.firstYearEarning)
            amountAvalable = Int(caculate.amountAvailable)
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
                forReloadData.moneySavingPerYear.firstYearEarning = self.averages.last?.firstYearEarning ?? 0
                forReloadData.amountAvailable = self.averages.last?.amountAvailable ?? 0
                forReloadData.currencyUnit = self.averages.last?.currencyUnit ?? ""
                forReloadData.interest = self.averages.last?.bankInterest ?? 0
                forReloadData.moneySavingPerYear.years = Int(self.averages.last?.year ?? 0)
                forReloadData.moneySavingPerYear.percentOfIncomeForSaving = Double(self.averages.last?.percentForSaving ?? 0)
                forReloadData.moneySavingPerYear.isPercent = self.averages.last?.percentOrNumber ?? true
                forReloadData.moneySavingPerYear.annualIncomeIcreases = self.averages.last?.anualIcrease ?? 0
               
                let sumArray = averageNumbers.reduce(0, +)
                let avgArrayValue = (sumArray / Double(averageNumbers.count)*100).rounded()/100
                 avergaLabel.text = "Average percentage savings : \(avgArrayValue)%"
            }
            
        }catch {}
        

    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if amountAvailableTextField.isEditing {
            updateRealTime(number: amountAvalable, string: string)
        }else {
            updateRealTime(number: firstEarning, string: string)
        }
        
        return false
    }
    
    func updateRealTime (number:Int,string:String) {
        if let digit = Int(string) {
            if amountAvailableTextField.isEditing {
                amountAvalable = number * 10 + digit
                amountAvailableTextField.text = updateToCurrency(number: amountAvalable)
            }else {
                firstEarning = number * 10 + digit
                firstYearEarningTextField.text = updateToCurrency(number: firstEarning)
            }
            
        }
        if string == "" {
            
            if amountAvailableTextField.isEditing {
                amountAvalable = number/10
                amountAvailableTextField.text = updateToCurrency(number: number)
            }else {
                firstEarning = number/10
                firstYearEarningTextField.text = updateToCurrency(number: number)
            }
        }
    }
    
    func updateToCurrency(number: Int) ->String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let amount = Int(number)
        return formatter.string(from: NSNumber(value: amount))
    }
   
    @IBAction func caculateResult(_ sender: UIButton) {
        guard let annualIncomeIcreases = annualIncomeTextField.text,
            annualIncomeIcreases != "",
            let percentOfIncomeForSaving = percentageForSavingTextField.text,
            percentOfIncomeForSaving != "",
            let years = yearsTextField.text,
            years != "",
            let currencyUnitValue = currencyUnitTextField.text,
            let interest = bankInterestTextField.text,
            interest != ""
        else {
            AlertController.showAlert(inController: self, tilte: "Input Error", message: "Please filling out all required fields")
            return
        }
        
        let firstYearEarningDouble:Double = Double(firstEarning)
        let annualIncomeIcreasesDbouble:Double? = Double(annualIncomeIcreases)
        let percentOfIncomeForSavingDouble:Double? = Double(percentOfIncomeForSaving)
        let yearsInt:Int? = Int(years)
        let amountAvailableDouble:Double = Double(amountAvalable)
        let interestDouble:Double? = Double(interest)
        
        if  firstYearEarningDouble >= 0,
            let annualIncomeIcreasesDbouble = annualIncomeIcreasesDbouble,
            annualIncomeIcreasesDbouble >= 0,
            let percentOfIncomeForSavingDouble = percentOfIncomeForSavingDouble,
            percentOfIncomeForSavingDouble >= 0,
            let yearsInt = yearsInt,
            yearsInt >= 1,
            amountAvailableDouble >= 0,
            let interestDouble = interestDouble,
            interestDouble >= 0
        {
            if percentOfIncomeForSavingDouble > 100  {
                AlertController.showAlert(inController: self, tilte: "Something wrong", message: "Percent of income for saving have to less than 100")
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
            average.currencyUnit = currencyUnitValue
            average.anualIcrease = annualIncomeIcreasesDbouble
            average.amountAvailable = amountAvailableDouble
            average.bankInterest = interestDouble
            average.firstYearEarning = firstYearEarningDouble
            average.percentForSaving = percentOfIncomeForSavingDouble
            average.percentOrNumber = caculate.moneySavingPerYear.isPercent
            average.year = Int16(yearsInt)
            
            PersitenceService.saveContext()
            averages.append(average)
        } else {
             AlertController.showAlert(inController: self, tilte: "Input Error", message: "Maybe some field wasn't correct.")
        }
      
    }
    
    @IBAction func recentRecord(_ sender: UIButton) {
        if self.averages.count != 0 {
            currencyUnitTextField.text = averages.last!.currencyUnit
            amountAvailableTextField.text = String(averages.last!.amountAvailable)
            firstYearEarningTextField.text = String(averages.last!.firstYearEarning)
            annualIncomeTextField.text = String(averages.last!.anualIcrease)
            percentageForSavingTextField.text = String(averages.last!.percentForSaving)
            yearsTextField.text = String(averages.last!.year)
            bankInterestTextField.text = String(averages.last!.bankInterest)
            firstEarning = Int(averages.last!.firstYearEarning)
            amountAvalable = Int(averages.last!.amountAvailable)
        }else {
            recentButton.isEnabled = false
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


