//
//  Item.swift
//  ToDoApp
//
//  Created by Grace Tay on 12/22/17.
//  Copyright © 2017 Grace Tay. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
