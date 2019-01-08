//
//  Conversation+CoreDataProperties.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 02/12/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Conversation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Conversation> {
        return NSFetchRequest<Conversation>(entityName: "Conversation")
    }

    @NSManaged public var online: Bool
    @NSManaged public var name: String?
    @NSManaged public var message: String?
    @NSManaged public var hasUnreadMessage: Bool
    @NSManaged public var date: NSDate?
    @NSManaged public var conversationId: String?

}
