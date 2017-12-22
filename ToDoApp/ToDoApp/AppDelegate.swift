//
//  AppDelegate.swift
//  ToDoApp
//
//  Created by Grace Tay on 12/19/17.
//  Copyright © 2017 Grace Tay. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //print(Realm.Configuration.defaultConfiguration.fileURL)

        
        do {
            _ = try Realm()

        } catch {
            print("Error initializing \(error)")
        }
    
        return true
    }

}

