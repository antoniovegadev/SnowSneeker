//
//  Resort.swift
//  SnowSeeker
//
//  Created by Antonio Vega on 8/20/21.
//
import Foundation

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { a, b in
            a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

struct Resort: Codable, Identifiable {
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]

    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
}
