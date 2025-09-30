//
//  PhoneBook+CoreDataProperties.swift
//  PokemonPhoneBook
//
//  Created by oww on 9/30/25.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var image: Data?

}

extension PhoneBook : Identifiable {

}
