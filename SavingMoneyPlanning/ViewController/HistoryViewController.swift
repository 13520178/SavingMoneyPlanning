//
//  HistoryViewController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 10/19/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var savings = [Saving]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest: NSFetchRequest<Saving> = Saving.fetchRequest()
        
        do {
            savings = try PersitenceService.context.fetch(fetchRequest)
        }catch {}
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "history cell") as! HIstoryCell
        
        cell.parrentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.parrentView.layer.cornerRadius = 6
        
        //Set shadow
        
        cell.shadowView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.shadowView.layer.shadowOpacity = 0.7
        cell.shadowView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.shadowView.layer.shadowRadius = 6
        
        cell.nameLabel.text = savings[indexPath.row].name! + " " + "(" + savings[indexPath.row].unit! + ")"
        cell.amountAvailableLabel.text = String(savings[indexPath.row].amountAvailable)
        cell.firstYearEarningLabel.text = String(savings[indexPath.row].firstYearEarning)
        cell.anualIncomeIncreaseLabel.text = String(savings[indexPath.row].anualIncomeIncrease)
        cell.interestLabel.text = String(savings[indexPath.row].interest)
        cell.percentForSavingLabel.text = String(savings[indexPath.row].percentForSaving)
        cell.yearsLabel.text = String(savings[indexPath.row].years)
        
        return cell
    }
}
