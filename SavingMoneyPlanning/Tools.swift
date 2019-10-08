//
//  Tools.swift
//  SavingMoneyPlanning
//
//  Created by Apple on 9/8/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import Foundation

class Tools {

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
}
