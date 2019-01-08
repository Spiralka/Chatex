//
//  Profile+CoreDataProperties.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 20/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var about: String?
    @NSManaged public var image: NSData?

}
