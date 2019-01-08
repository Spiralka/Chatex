//
//  Message+CoreDataProperties.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 02/12/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }
    

    @NSManaged public var date: NSDate
    @NSManaged public var text: String?
    @NSManaged public var identifier: String?
    @NSManaged public var isIncoming: Bool
    @NSManaged public var readed: Bool
    @NSManaged public var type: String?

    
    
    
    
}
