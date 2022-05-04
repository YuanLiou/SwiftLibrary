//
//  Book+CoreDataProperties.swift
//  SwiftLibrary
//
//  Created by 劉瑞元 on 2022/4/14.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var publishDate: String?
    @NSManaged public var author: String?
    @NSManaged public var desc: String?
    @NSManaged public var descUri: String?
    @NSManaged public var id: String?
    @NSManaged public var imageUri: String?
    @NSManaged public var rating: NSNumber?
    @NSManaged public var title: String?

}

extension Book : Identifiable {

}
