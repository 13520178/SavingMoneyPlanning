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
    
    var caculate = CaculateTheSavingMoney()
    var total = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        let moneyForSaving = String((caculate.moneySavingPerYear.resultPerYears[indexPath.row + 1].money*100).rounded()/100)
        cell.moneyForSavingLabel.text = Tools.changeToCurrency(moneyStr: moneyForSaving)
        
        let totalInTheBank = String((caculate.moneyPerYear[indexPath.row]*100).rounded()/100)
        cell.totalInTheBankLabel.text =  Tools.changeToCurrency(moneyStr: totalInTheBank)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToTotal" {
            if let destination = segue.destination as? TotalResultViewController {
                destination.caculate = caculate
            }
        }
    }
    

}
