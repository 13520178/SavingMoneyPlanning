//
//  Tools.swift
//  SavingMoneyPlanning
//
//  Created by Apple on 9/8/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import Foundation

class Tools {
    
    //For VN
    static func addDotToCurrencyString(money:String,cha:Character) -> String {
        var newMoney = money
        if newMoney.count == 4 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 1))
        }else if newMoney.count == 5 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 2))
        }else if newMoney.count == 6 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 3))
        }else if newMoney.count == 7 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 4))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 1))
        }else if newMoney.count == 8 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 5))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 2))
        }else if newMoney.count == 9 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 6))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 3))
        }else if newMoney.count == 10 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 7))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 4))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 1))
        }else if newMoney.count == 11 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 8))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 5))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 2))
        }else if newMoney.count == 12 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 9))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 6))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 3))
        }else if newMoney.count == 13 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 10))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 7))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 4))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 1))
        }else if newMoney.count == 14 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 11))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 8))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 5))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 2))
        }else if newMoney.count == 15 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 12))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 9))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 6))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 3))
        }else if newMoney.count == 16 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 13))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 10))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 7))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 4))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 1))
        }else if newMoney.count == 17 {
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 14))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 11))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 8))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 5))
            newMoney.insert(cha, at: money.index(money.startIndex, offsetBy: 2))
        }
        return newMoney
    }
    
    static func fixCurrencyTextInTextfield(moneyStr:String) ->String? {
        var afterFixString = moneyStr
        
        
        if(Tools.country == "VN") {
            
            afterFixString = afterFixString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            
            let numOfComma = moneyStr.components(separatedBy:",").count - 1
            if numOfComma > 1 {
                afterFixString = String(afterFixString.dropLast())
            }
            
            var commaStringArray = afterFixString.components(separatedBy: ",")
            var beforeCommaString = commaStringArray[0]
            if beforeCommaString.count >= 15 {
                beforeCommaString = String(beforeCommaString.dropLast())
            }
            beforeCommaString = Tools.addDotToCurrencyString(money: beforeCommaString, cha: ".")
            
            print(beforeCommaString)
            
            if commaStringArray.count == 2 {
                var afterCommaString = commaStringArray[1]
                if afterCommaString.count > 2 {
                    afterCommaString = String(afterCommaString.dropLast())
                }
                print(afterCommaString)
                return beforeCommaString + "," + afterCommaString
            }
            return beforeCommaString
            
            
        }else {
            
             afterFixString = afterFixString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            
            let numOfDot = moneyStr.components(separatedBy:".").count - 1
            if numOfDot > 1 {
                afterFixString = String(afterFixString.dropLast())
            }
            
            var commaStringArray = afterFixString.components(separatedBy: ".")
            var beforeCommaString = commaStringArray[0]
            if beforeCommaString.count >= 15 {
                beforeCommaString = String(beforeCommaString.dropLast())
            }
            beforeCommaString = Tools.addDotToCurrencyString(money: beforeCommaString, cha: ",")
            
            print(beforeCommaString)
            
            if commaStringArray.count == 2 {
                var afterCommaString = commaStringArray[1]
                if afterCommaString.count > 2 {
                    afterCommaString = String(afterCommaString.dropLast())
                }
                print(afterCommaString)
                return beforeCommaString + "." + afterCommaString
            }
            return beforeCommaString
            
        }
        
    }
    
    static func getMoneyFromTextFieldToUsing(ftString:String) ->String {
        var resultString = ftString
        if(Tools.country == "VN") {
            resultString = resultString.replacingOccurrences(of: ".", with: "")
        }else {
            resultString = resultString.replacingOccurrences(of: ",", with: "")
        }
        return resultString
        
    }
    
    //Old method

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
    
    static func replaceDotOrComma(string:String) -> String {
        let newString = string.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
        return newString
    }
    
    static let stringDaily = NSLocalizedString("stringDaily", comment: "stringDaily")
    static let stringWeekly = NSLocalizedString("stringWeekly", comment: "stringWeekly")
    static let stringMonthly = NSLocalizedString("stringMonthly", comment: "stringMonthly")
    static let stringQuarterly = NSLocalizedString("stringQuarterly", comment: "stringQuarterly")
    static let stringAnnually = NSLocalizedString("stringAnnually", comment: "stringAnnually")
    
    static let averagePercentSaving = NSLocalizedString("averagePercentSaving", comment: "averagePercentSaving")
    static let inputError = NSLocalizedString("inputError", comment: "inputError")
    static let errorDuringDataEntry = NSLocalizedString("errorDuringDataEntry", comment: "errorDuringDataEntry")
    static let hideCalculator = NSLocalizedString("hideCalculator", comment: "hideCalculator")
    static let showCalculator = NSLocalizedString("showCalculator", comment: "showCalculator")
     static let changeCurrency = NSLocalizedString("changeCurrency", comment: "changeCurrency")
    static let enterTheConversionFactor = NSLocalizedString("enterTheConversionFactor", comment: "enterTheConversionFactor")
    static let error = NSLocalizedString("error", comment: "error")
    static let pleaseFillCorrect = NSLocalizedString("pleaseFillCorrect", comment: "pleaseFillCorrect")
    static let putWrongPlace = NSLocalizedString("putWrongPlace", comment: "putWrongPlace")
    
    static let defaultCompoundPeriod = NSLocalizedString("defaultCompoundPeriod", comment: "defaultCompoundPeriod")
    
    static let country = NSLocalizedString("country", comment: "country")
}
