//
//  HIstoryCell.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 10/19/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class HIstoryCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var parrentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountAvailableLabel: UILabel!
    @IBOutlet weak var firstYearEarningLabel: UILabel!
    
    @IBOutlet weak var anualIncomeIncreaseLabel: UILabel!
    
    @IBOutlet weak var percentForSavingLabel: UILabel!
    
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
}
