//
//  Average+CoreDataProperties.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 9/11/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//
//

import Foundation
import CoreData


extension Average {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Average> {
        return NSFetchRequest<Average>(entityName: "Average")
    }

    @NSManaged public var number: Double
    @NSManaged public var currencyUnit: String?
    @NSManaged public var amountAvailable: Double
    @NSManaged public var firstYearEarning: Double
    @NSManaged public var percentForSaving: Double
    @NSManaged public var percentOrNumber: Bool
    @NSManaged public var year: Int16
    @NSManaged public var bankInterest: Double
    @NSManaged public var anualIcrease: Double

}
