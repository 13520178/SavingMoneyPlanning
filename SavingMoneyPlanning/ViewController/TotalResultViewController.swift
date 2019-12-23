//
//  TotalResultViewController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/25/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit
import Charts

class TotalResultViewController: UIViewController {

    
    @IBOutlet weak var pieView: PieChartView!
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
    @IBOutlet weak var totalDepositLabel: UILabel!
    @IBOutlet weak var totalInterestLabel: UILabel!
    

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var changeResult: UILabel!
    var caculate = CaculateTheSavingMoney()
    var total = Double()
    var change = Double ()
    var exchangeTF = UITextField()
    var dataForChart = PercentForPieChart()
    
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
        
        //Charts
        
        dataForChart = PercentForPieChart(initial: caculate.amountAvailable, firstYear: caculate.moneySavingPerYear.firstYearEarning, incomeIncrease: caculate.moneySavingPerYear.annualIncomeIcreases, isPercent: caculate.moneySavingPerYear.isPercent, years: caculate.moneySavingPerYear.years, percentForSaving: caculate.moneySavingPerYear.percentOfIncomeForSaving)
        
        dataForChart.totalInterest = ((total - dataForChart.totalDeposit)*100).rounded()/100
        
        dataForChart.percentInterest = (dataForChart.totalInterest/total)*100
        dataForChart.percentInterest = (dataForChart.percentInterest*100).rounded()/100
        
        dataForChart.percentDeposit = ((100 - dataForChart.percentInterest)*100).rounded()/100
        
        
        print("Total: \(total)")
        print("Total deposit: \(dataForChart.totalDeposit)")
        print("Total interest: \(dataForChart.totalInterest)")
        print("Percent deposit: \(dataForChart.percentDeposit)%")
        print("Percent interest: \(dataForChart.percentInterest)%")
        
        totalDepositLabel.text = (Tools.changeToCurrency(moneyStr: String(dataForChart.totalDeposit)) ?? "0") + " " + String(caculate.currencyUnit)
        totalInterestLabel.text = (Tools.changeToCurrency(moneyStr: String(dataForChart.totalInterest)) ?? "0") + " " + String(caculate.currencyUnit)
        
        setupPieChart(depositValue: dataForChart.totalDeposit, interestValue: dataForChart.totalInterest)
        
       
    }
    
//    @IBAction func saveNewButtonPressed(_ sender: UIButton) {
//        AlertController.addNewListAlert(in: self) { (name, isSuccess) in
//            if isSuccess {
//                let saving = Saving(context: PersitenceService.context)
//                saving.name = name
//                saving.amountAvailable = self.caculate.amountAvailable
//                saving.firstYearEarning = self.caculate.moneySavingPerYear.firstYearEarning
//                saving.anualIncomeIncrease = self.caculate.moneySavingPerYear.annualIncomeIcreases
//                saving.isPercent = self.caculate.moneySavingPerYear.isPercent
//                saving.percentForSaving = self.caculate.moneySavingPerYear.percentOfIncomeForSaving
//                saving.interest = self.caculate.interest
//                saving.years = Int16(self.caculate.moneySavingPerYear.years)
//                saving.unit = self.caculate.currencyUnit
//                
//                PersitenceService.saveContext()
//            }
//        }
//    }
    
    
    func setupPieChart(depositValue:Double, interestValue:Double) {
        pieView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: depositValue, label: "Deposit"))
        entries.append(PieChartDataEntry(value: interestValue, label: "Interest"))
        
        let dataSet = PieChartDataSet(entries: entries,label: "")
        
        dataSet.colors = [#colorLiteral(red: 0.9215686275, green: 0.4392156863, blue: 0.4392156863, alpha: 1),#colorLiteral(red: 0.3921568627, green: 0.8862745098, blue: 0.568627451, alpha: 1)]
        dataSet.drawValuesEnabled = true
    
        dataSet.sliceSpace = 2.0
        

        pieView.usePercentValuesEnabled = true
        pieView.drawSlicesUnderHoleEnabled = false
        pieView.holeRadiusPercent = 0.40
        pieView.transparentCircleRadiusPercent = 0.43
        pieView.drawHoleEnabled = true
        pieView.rotationAngle = 0.0
        pieView.rotationEnabled = true
        pieView.highlightPerTapEnabled = false
        
        let pieChartLegend = pieView.legend
        pieChartLegend.horizontalAlignment = Legend.HorizontalAlignment.right
        pieChartLegend.verticalAlignment = Legend.VerticalAlignment.top
        pieChartLegend.orientation = Legend.Orientation.vertical
        pieChartLegend.drawInside = false
        pieChartLegend.yOffset = 10.0
        
        pieView.legend.enabled = true
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
       
        
        let pieChartData = PieChartData(dataSet: dataSet)
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        
        pieView.data = pieChartData
        
        
        
    }

    
    @IBAction func conver(_ sender: UIButton) {
        let alertController = UIAlertController(title: Tools.changeCurrency, message: Tools.enterTheConversionFactor, preferredStyle: .alert)
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


