//
//  DataService.swift
//  English
//
//  Created by Andrey on 07.08.2021.
//

import Foundation
class DataService {
    static var sharet = DataService()
    var favorites: [Translate] = []
    var isWhite = true
    static func saveTasks(data:[Translate]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(data), forKey: "Trans")
    }
    
    static func loadTasks() -> [Translate]? {
        if let data = UserDefaults.standard.value(forKey: "Trans") as? Data{
            if let taskArray = try? PropertyListDecoder().decode(Array<Translate>.self, from: data){
                return taskArray
            }
        }
        return nil
    }
}





