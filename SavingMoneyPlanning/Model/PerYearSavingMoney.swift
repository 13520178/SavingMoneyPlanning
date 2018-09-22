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
    
    //số tiền lương mỗi năm for saving
    var money:Double
    
    var salary:Double
    
    init(year:Int, money:Double,salary:Double) {
        self.year = year
        self.money = money
        self.salary = salary
    }
}
