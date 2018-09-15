//
//  Tools.swift
//  SavingMoneyPlanning
//
//  Created by Apple on 9/8/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import Foundation

class Tools {
//    static func changeToCurrency (moneyStr: String) -> String{
//        var moneyString = moneyStr
//        var number = moneyString.count
//        if number >= 4 {
//            var num = 1
//            for (index, value) in moneyString.enumerated() {
//                if value == "." && index == number - 3 {
//                    for c in moneyString.indices {
//                        if num%4 == 0 && num != 0 && num != (number - 2) {
//                            moneyString.insert(",", at:c )
//                            number = number + 1
//                        }
//                        num = num + 1
//                    }
//                }else if value == "." && index == number - 2{
//                    for c in moneyString.indices {
//                        if num%4 == 0 && num != 0 && num != (number - 1) {
//                            moneyString.insert(",", at:c )
//                            number = number + 1
//                        }
//                        num = num + 1
//                    }
//                }
//            }
//
//        }
//        return moneyString
//    }
//
    static func changeToCurrency(moneyStr:String) ->String? {
        let number:Double? = Double(moneyStr)
        if let number = number {
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.decimal
            return formatter.string(from: NSNumber(value: number))
        }
      return ""
    }
    
    static func replaceSpace(string:String) -> String {
        let newString = string.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        return newString
    }
}
