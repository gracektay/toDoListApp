//
//  Category.swift
//  ToDoApp
//
//  Created by Grace Tay on 12/22/17.
//  Copyright © 2017 Grace Tay. All rights reserved.
//

import Foundation

import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<Item>()
    
}
