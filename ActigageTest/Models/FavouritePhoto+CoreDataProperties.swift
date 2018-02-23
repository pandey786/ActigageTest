//
//  FavouritePhoto+CoreDataProperties.swift
//  
//
//  Created by Durgesh Pandey on 19/12/17.
//
//

import Foundation
import CoreData


extension FavouritePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePhoto> {
        return NSFetchRequest<FavouritePhoto>(entityName: "FavouritePhoto")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var title: String?

}
