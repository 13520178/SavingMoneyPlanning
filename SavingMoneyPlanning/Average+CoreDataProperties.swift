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
}
