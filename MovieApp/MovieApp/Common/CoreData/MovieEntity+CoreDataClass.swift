//
//  MovieEntity+CoreDataClass.swift
//  MovieApp
//
//  Created by Adem Tarhan on 26.08.2022.
//
//

import Foundation
import CoreData

@objc(MovieEntity)
public class MovieEntity: NSManagedObject {

}


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var voteAverage: Double

}

extension MovieEntity : Identifiable {

}
