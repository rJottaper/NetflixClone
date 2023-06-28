//
//  MovieDownload+CoreDataProperties.swift
//  Netflix
//
//  Created by João Pedro on 26/06/23.
//
//

import Foundation
import CoreData


extension MovieDownload {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDownload> {
        return NSFetchRequest<MovieDownload>(entityName: "MovieDownload")
    }

    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?

}

extension MovieDownload : Identifiable {

}
