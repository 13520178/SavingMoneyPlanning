//
//  DetailViewController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/28/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalSavingStackView: UIStackView!
    
    var caculate = CaculateTheSavingMoney()
    var total = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        totalSavingStackView.layer.borderWidth = 1
        totalSavingStackView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        totalLabel.text = Tools.changeToCurrency(moneyStr: String(total))! + " " + caculate.currencyUnit
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caculate.moneyPerYear.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DetailTableViewCell
        
        cell.yearLabel.text = String(caculate.moneySavingPerYear.resultPerYears[indexPath.row].year + 1)
        
        let income = String((caculate.moneySavingPerYear.resultPerYears[indexPath.row + 1].salary*100).rounded()/100)
        cell.income.text = Tools.changeToCurrency(moneyStr: income)! + " " + caculate.currencyUnit
        
        let moneyForSaving = String((caculate.moneySavingPerYear.resultPerYears[indexPath.row + 1].money*100).rounded()/100)
        cell.moneyForSavingLabel.text = Tools.changeToCurrency(moneyStr: moneyForSaving)! + " " + caculate.currencyUnit
        
        let spendingMoney = String((caculate.moneySavingPerYear.resultPerYears[indexPath.row + 1].salary*100).rounded()/100 - ((caculate.moneySavingPerYear.resultPerYears[indexPath.row + 1].money*100).rounded()/100))
        cell.spendingMoney.text = Tools.changeToCurrency(moneyStr: spendingMoney)! + " " + caculate.currencyUnit
        
        let totalInTheBank = String((caculate.moneyPerYear[indexPath.row]*100).rounded()/100)
        cell.totalInTheBankLabel.text =  Tools.changeToCurrency(moneyStr: totalInTheBank)! + " " + caculate.currencyUnit
        return cell
    }
    
}
