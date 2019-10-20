//
//  Saving+CoreDataProperties.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 10/20/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//
//

import Foundation
import CoreData


extension Saving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saving> {
        return NSFetchRequest<Saving>(entityName: "Saving")
    }

    @NSManaged public var name: String?
    @NSManaged public var unit: String?
    @NSManaged public var amountAvailable: Double
    @NSManaged public var firstYearEarning: Double
    @NSManaged public var anualIncomeIncrease: Double
    @NSManaged public var isPercent: Bool
    @NSManaged public var percentForSaving: Double
    @NSManaged public var interest: Double
    @NSManaged public var years: Int16

}
