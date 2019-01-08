//
//  CoreDataManager.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataProtocol {
    func save(name: String?, about: String?, image: UIImage?, handler: @escaping (Bool) -> Void)
    func read(handler: @escaping (_ name:String,_ about: String,_ image: UIImage) -> Void)
}

class CoreDataManager: CoreDataProtocol {
    
    //TODO: - прописать работу с кордатой
    
    var profileEntity: Profile?
    let coreDataStack = CoreDataStack()
    
    func save(name: String?, about: String?, image: UIImage?, handler: @escaping (Bool) -> Void) {
        let context = self.coreDataStack.saveContext
        let profile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: coreDataStack.saveContext) as? Profile
        if let name = name {
            profile?.name = name
            print("I'm saving: \(String(describing: profile?.name)) ")
        }
        if let about = about {
            profile?.about = about
            print("I'm saving: \(String(describing: profile?.about)) ")
            
        }
        if let image = image {
            profile?.image = image.pngData()! as NSData
            print("I'm saving: \(String(describing: profile?.image)) ")
        }
        
        self.coreDataStack.trySave(context: context)
    }
    
    func read(handler: @escaping (String, String, UIImage) -> Void) {
        let context = self.coreDataStack.readContext
        let request = NSFetchRequest<Profile>(entityName: "Profile")
        let result = try? context.fetch(request)
        let profile = result?.last
        
        async {
            guard  let name = profile?.name else { return }
            guard  let about = profile?.about else { return }
            guard let image = profile?.image else { return }
            handler(name, about, UIImage(data: image as Data) ?? UIImage(named: "someGirl.png")!)
        }
    }
    }
    
    

