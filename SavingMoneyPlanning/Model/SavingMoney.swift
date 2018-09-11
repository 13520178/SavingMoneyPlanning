//
//  SavingMoney.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/26/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import Foundation

struct SavingMoney {
    //tổng số tiền làm được năm đầu tiên
    var firstYearEarning = Double()
    
    //tiền tăng mỗi năm
    var annualIncomeIcreases = Double()
    
    //phần trăm tiết kiệm trong tổng
    var percentOfIncomeForSaving = Double()
    
    //số năm
    var years = Int()
    
    //phần trăm hay số
    var isPercent = Bool()
    
    //kết quả của từng năm
    var resultPerYears = [PerYearSavingMoney]()
    
    //tính toán số tiền tiết kiệm mỗi năm
    mutating func caculateMoneyForSavingPerYears() -> [PerYearSavingMoney] {
        var resultPerYear = PerYearSavingMoney(year: 0, money: 0)
        resultPerYears += [resultPerYear]
        var moneyMakePerYear = firstYearEarning
        for year in 1...years {
            if isPercent {
                if year == 1 {
                    resultPerYear = PerYearSavingMoney(year: year, money: moneyMakePerYear*(percentOfIncomeForSaving/100))
                    resultPerYears += [resultPerYear]
                } else {
                    moneyMakePerYear = moneyMakePerYear*(1+annualIncomeIcreases/100)
                    resultPerYear = PerYearSavingMoney(year: year, money: moneyMakePerYear*(percentOfIncomeForSaving/100))
                    resultPerYears += [resultPerYear]
                }
            } else {
                if year == 1 {
                    resultPerYear = PerYearSavingMoney(year: year, money: moneyMakePerYear*(percentOfIncomeForSaving/100))
                    resultPerYears += [resultPerYear]
                } else {
                    moneyMakePerYear = moneyMakePerYear+(annualIncomeIcreases)
                    resultPerYear = PerYearSavingMoney(year: year, money: moneyMakePerYear*(percentOfIncomeForSaving/100))
                    resultPerYears += [resultPerYear]
                }
            }
        }
        return resultPerYears
    }
}
