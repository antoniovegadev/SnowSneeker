//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Antonio Vega on 8/21/21.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        let filename = Self.getDocumentsDirectory().appendingPathComponent(saveKey)
        
        if let data = try? Data(contentsOf: filename) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decoded
                return
            }
        }
        
        // still here? Use an empty array
        self.resorts = []
    }
    
    static private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        do {
            let filename = Self.getDocumentsDirectory().appendingPathComponent(saveKey)
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            
        }
    }
}
