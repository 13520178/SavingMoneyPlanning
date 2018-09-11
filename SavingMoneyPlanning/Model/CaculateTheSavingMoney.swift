//
//  CaculateTheSavingMoney.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/26/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import Foundation

struct CaculateTheSavingMoney {
    
    //số tiền có ban đầu
    var amountAvailable = Double()
    
    //số tiền tiết kiệm từng năm
    var moneySavingPerYear = SavingMoney()
    var interest = Double()
    var moneyPerYear = [Double]()
    var currencyUnit = String()
    
    mutating func caculate() -> [Double] {
        moneySavingPerYear.resultPerYears = moneySavingPerYear.caculateMoneyForSavingPerYears()
        var result:Double = amountAvailable
        for year in 1...moneySavingPerYear.years {
            result = (result+moneySavingPerYear.resultPerYears[year-1].money) * (1+interest/100)
            moneyPerYear += [result]
        }
        return moneyPerYear
    }
}
