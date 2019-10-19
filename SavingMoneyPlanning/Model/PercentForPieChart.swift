//
//  percentForPieChart.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 10/19/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import Foundation

class PercentForPieChart {
    
    var initial = Double()
    var firstYear = Double()
    var incomeIncrease = Double()
    var isPercent = Bool()
    var years = Int()
    var percentForSaving = Double()
    
    var totalDeposit = Double()
    var totalInterest = Double()
    var percentDeposit = Double()
    var percentInterest = Double()
    
    init() {
        
    }
    
    init(initial:Double, firstYear:Double, incomeIncrease:Double, isPercent:Bool, years:Int,percentForSaving:Double) {
        self.initial = initial
        self.firstYear = firstYear
        self.incomeIncrease = incomeIncrease
        self.isPercent = isPercent
        self.years = years
        self.percentForSaving = percentForSaving
        
        totalDepositCalculator()
    }
    
    func totalDepositCalculator() {
        if isPercent {
            var perYearEarning = firstYear
            for i in 1...years {
                if i == 1 {
                    totalDeposit += perYearEarning*(percentForSaving/100)
                    print(totalDeposit)
                }else {
                    perYearEarning = perYearEarning + perYearEarning * (incomeIncrease/100)
                    totalDeposit += perYearEarning*(percentForSaving/100)
                    print(totalDeposit)
                }
                
            }
            
            totalDeposit += initial
            
        }else {
            var perYearEarning = firstYear
            for i in 1...years {
                if i == 1 {
                    totalDeposit += perYearEarning*(percentForSaving/100)
                    print(totalDeposit)
                }else {
                    perYearEarning = perYearEarning + incomeIncrease
                    totalDeposit += perYearEarning*(percentForSaving/100)
                    print(totalDeposit)
                }
                
            }
            totalDeposit += initial
           
        }
        totalDeposit = (totalDeposit*100).rounded()/100
        print("All deposit: \(totalDeposit)")
    }
    
}
