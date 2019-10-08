//
//  CompoundInterestModel.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 9/12/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import Foundation

class CompoundInterestModel {
    var pincipal = Double()
    var time = Int()
    var interest = Double()
    var compound = Int()
    
    func calculate() -> Double {
        interest = interest/100
        var amount = Double()
        
        amount = pow((1 + (interest/Double(compound))),Double(compound * time))
        amount = pincipal * amount
        
        return amount
    }
    
}
