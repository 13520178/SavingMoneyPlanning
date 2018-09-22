//
//  DetailTableViewCell.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/28/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var moneyForSavingLabel: UILabel!
    @IBOutlet weak var totalInTheBankLabel: UILabel!
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var spendingMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
