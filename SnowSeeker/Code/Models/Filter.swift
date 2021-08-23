//
//  Filter.swift
//  SnowSeeker
//
//  Created by Antonio Vega on 8/21/21.
//

struct Filter {
    var country: String? = nil
    var size: Int? = nil
    var price: Int? = nil
    
    static let countries = ["United States", "France", "Canada", "Italy", "Austria"]
    static let sizes = [1, 2, 3]
    static let prices = [2, 3]
}
