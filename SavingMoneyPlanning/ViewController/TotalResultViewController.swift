//
//  TotalResultViewController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/25/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit

class TotalResultViewController: UIViewController {

    
    @IBOutlet weak var currencyUnitLabel: UILabel!
    @IBOutlet weak var amountAvailable: UILabel!
    @IBOutlet weak var firstYearEarnings: UILabel!
    @IBOutlet weak var annualIncomeIncreasesLabel: UILabel!
    @IBOutlet weak var percentOfIncomeForSavingLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var bankInterstRateLabel: UILabel!
    @IBOutlet weak var totalInBankLabel: UILabel!
    @IBOutlet weak var lastYearSavingMoneyLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var changeResult: UILabel!
    var caculate = CaculateTheSavingMoney()
    var total = Double()
    var change = Double ()
    var exchangeTF = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView.layer.borderWidth = 1
        firstView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        secondView.layer.borderWidth = 1
        secondView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        changeResult.layer.borderWidth = 1
        changeResult.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        currencyUnitLabel.text =  String(caculate.currencyUnit)
        amountAvailable.text = Tools.changeToCurrency(moneyStr:String(caculate.amountAvailable) )
        
        firstYearEarnings.text = Tools.changeToCurrency(moneyStr: String(caculate.moneySavingPerYear.firstYearEarning))
        annualIncomeIncreasesLabel.text = String(caculate.moneySavingPerYear.annualIncomeIcreases)
        percentOfIncomeForSavingLabel.text = String(caculate.moneySavingPerYear.percentOfIncomeForSaving)
        yearsLabel.text = String(caculate.moneySavingPerYear.years)
        bankInterstRateLabel.text = String(caculate.interest)
        let bankMoneyPerYear = caculate.moneyPerYear
        let savingMoneyPerYear = caculate.moneySavingPerYear.resultPerYears
        totalInBankLabel.text = Tools.changeToCurrency(moneyStr:String(((bankMoneyPerYear.last!*100).rounded()/100)) )! + " " + String(caculate.currencyUnit)
        lastYearSavingMoneyLabel.text = Tools.changeToCurrency(moneyStr: (String((savingMoneyPerYear.last!.money*100).rounded()/100)))! + " " + String(caculate.currencyUnit)
        total = ((bankMoneyPerYear.last! + savingMoneyPerYear.last!.money) * 100).rounded()/100
        totalLabel.text = Tools.changeToCurrency(moneyStr:String(total) )! + " " + String(caculate.currencyUnit)

       
    }

    
    @IBAction func conver(_ sender: UIButton) {
        let alertController = UIAlertController(title: Tools.changeCurrency, message: "Enter the conversion factor (Ex. 100 or 1/100)", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: exchangeTF)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func exchangeTF(textField:UITextField!) {
        exchangeTF = textField
        exchangeTF.keyboardType = .numbersAndPunctuation
        exchangeTF.placeholder = "Ex. 25 000"
        
    }
    
    func okHandler(alert: UIAlertAction!) {
        var secondNumber = String ()
        var firstNumber = String ()
        var firstNumberArray = [String] ()
        var secondNumberArray = [String] ()
        if var exchangeValue = exchangeTF.text{
            exchangeValue = Tools.replaceSpace(string: exchangeValue)
            let exchangeValueDouble:Double? = Double(exchangeValue)
            if let exchangeValueDouble = exchangeValueDouble {
                changeResult.text = Tools.changeToCurrency(moneyStr: String(exchangeValueDouble * total))
                changeResult.isHidden = false
            }else if exchangeValue.contains("/") {
                var num = 0
                for (index, value) in exchangeValue.enumerated() {
                    if value == "/" {
                        num = num + 1
                        if index == 0 || index == (exchangeValue.count - 1) {
                            AlertController.showAlert(inController: self, tilte: Tools.error, message: Tools.putWrongPlace )
                            return
                        }
                    }
                }
                if num >= 2 {
                    AlertController.showAlert(inController: self, tilte: Tools.error, message: Tools.putWrongPlace)
                    return
                }else {
                    var isFirstNumberDone = false
                    for (_, value) in exchangeValue.enumerated() {
                        if value != "/" && isFirstNumberDone == false {
                            firstNumberArray.append(String(value))
                        }else if value == "/" {
                            isFirstNumberDone = true                        }
                        else if isFirstNumberDone == true && value != "/" {
                            secondNumberArray.append(String(value))
                        }
                    }
                    for i in firstNumberArray {
                        firstNumber = firstNumber + i
                    }
                    for i in secondNumberArray {
                        secondNumber = secondNumber + i
                    }
                    let firstNumber:Double? = Double(firstNumber)
                    let secondNumber:Double? = Double(secondNumber)
                    
                    if let firstNumber = firstNumber, let secondNumber = secondNumber {
                        let zeroResult = Tools.error
                        let result = Tools.changeToCurrency(moneyStr: String(total*(firstNumber/secondNumber)))
                        changeResult.text = "\(result ?? zeroResult)"
                        changeResult.isHidden = false
                    }else {
                        AlertController.showAlert(inController: self, tilte: Tools.error, message: Tools.pleaseFillCorrect)
                    }
                }
            }else {
                  AlertController.showAlert(inController: self, tilte: Tools.error, message: Tools.pleaseFillCorrect)
            }
            
        }
    }
    
   
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let destination = segue.destination as? DetailViewController {
                destination.caculate = caculate
                destination.total = total
            }
        } else  if segue.identifier == "backInTotalTab" {
            if let destination = segue.destination as? InputViewController {
                destination.caculate = caculate
                destination.backFromTotal = true
            }
        }
    }
}
