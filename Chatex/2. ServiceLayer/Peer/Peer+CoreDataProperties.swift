//
//  Peer+CoreDataProperties.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 02/12/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//
//

import Foundation
import CoreData


extension Peer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Peer> {
        return NSFetchRequest<Peer>(entityName: "Peer")
    }

    @NSManaged public var name: String?
    @NSManaged public var identifier: String?
    @NSManaged public var peerID: NSObject?

}
