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
    @IBOutlet weak var exchangeView: UIView!
    

    
    @IBOutlet weak var changeResult: UILabel!
    var caculate = CaculateTheSavingMoney()
    var total = Double()
    var change = Double ()
    var exchangeTF = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
//        exchangeView.layer.borderWidth = 0.5
//        exchangeView.layer.borderColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
//        exchangeView.layer.cornerRadius = 8
        currencyUnitLabel.text =  String(caculate.currencyUnit)
        amountAvailable.text = Tools.changeToCurrency(moneyStr:String(caculate.amountAvailable) )
        
        firstYearEarnings.text = Tools.changeToCurrency(moneyStr: String(caculate.moneySavingPerYear.firstYearEarning))
        annualIncomeIncreasesLabel.text = String(caculate.moneySavingPerYear.annualIncomeIcreases)
        percentOfIncomeForSavingLabel.text = String(caculate.moneySavingPerYear.percentOfIncomeForSaving)
        yearsLabel.text = String(caculate.moneySavingPerYear.years)
        bankInterstRateLabel.text = String(caculate.interest)
        let bankMoneyPerYear = caculate.moneyPerYear
        let savingMoneyPerYear = caculate.moneySavingPerYear.resultPerYears
        totalInBankLabel.text = Tools.changeToCurrency(moneyStr:String(((bankMoneyPerYear.last!*100).rounded()/100)) )
        lastYearSavingMoneyLabel.text = Tools.changeToCurrency(moneyStr: (String((savingMoneyPerYear.last!.money*100).rounded()/100)))
        total = ((bankMoneyPerYear.last! + savingMoneyPerYear.last!.money) * 100).rounded()/100
        totalLabel.text = Tools.changeToCurrency(moneyStr:String(total) )! + " " + String(caculate.currencyUnit)

       
    }

    
    @IBAction func conver(_ sender: UIButton) {
       let alertController = UIAlertController(title: "Exchange", message: "Enter the new value that you want to exchange", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: exchangeTF)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func exchangeTF(textField:UITextField!) {
        exchangeTF = textField
        exchangeTF.placeholder = "Ex. 25000"
        
    }
    
    func okHandler(alert: UIAlertAction!) {
        if let exchangeValue = exchangeTF.text{
            let exchangeValueDouble:Double? = Double(exchangeValue)
            if let exchangeValueDouble = exchangeValueDouble {
                changeResult.text = Tools.changeToCurrency(moneyStr: String(exchangeValueDouble * total))
                changeResult.isHidden = false
            }
        }
    }
    
    @IBAction func backToViewController(_ sender: UIButton) {
      //  self.performSegue(withIdentifier: "backInTotalTab", sender: nil)
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
