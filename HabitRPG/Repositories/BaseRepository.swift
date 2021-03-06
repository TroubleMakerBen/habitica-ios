//
//  BaseRepository.swift
//  Habitica
//
//  Created by Phillip Thelen on 18.01.18.
//  Copyright © 2018 HabitRPG Inc. All rights reserved.
//

import Foundation

class BaseRepository {
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        return HRPGManager.shared().getManagedObjectContext()
    }()
    
    internal func makeFetchRequest<T: NSManagedObject>(entityName: String, predicate: NSPredicate) -> T? {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        let result = try? managedObjectContext.fetch(fetchRequest)
        if result?.count ?? 0 > 0, let item = result?[0] {
            return item
        }
        return nil
    }
}
