//
//  PerYearSavingMoney.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/26/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import Foundation

struct PerYearSavingMoney {
    //số năm nhập vào
    var year:Int
    
    //số tiền lương mỗi năm
    var money:Double
    
    init(year:Int, money:Double) {
        self.year = year
        self.money = money
    }
}
