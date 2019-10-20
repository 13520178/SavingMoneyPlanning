//
//  HistoryViewController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 10/19/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        
        return cell
    }
    
}
