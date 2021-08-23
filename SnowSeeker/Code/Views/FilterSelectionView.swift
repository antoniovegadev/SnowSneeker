//
//  FilterSelectionView.swift
//  SnowSeeker
//
//  Created by Antonio Vega on 8/21/21.
//

import SwiftUI

struct FilterSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var filter: Filter
        
    @State private var selectedCountry = "United States"
    @State private var selectedSize = 2
    @State private var selectedPrice = 2
    
    @State private var country = false
    @State private var size = false
    @State private var price = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Country", isOn: $country)
                    if country {
                        Picker("Select a country", selection: $selectedCountry) {
                            ForEach(Filter.countries, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                }
                
                Section {
                    Toggle("Size", isOn: $size)
                    if size {
                        Picker("Select a size", selection: $selectedSize) {
                            ForEach(Filter.sizes, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section {
                    Toggle("Price", isOn: $price)
                    if price {
                        Picker("Select a price", selection: $selectedPrice) {
                            ForEach(Filter.prices, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .navigationBarTitle("Filters")
            .navigationBarItems(trailing: Button("Apply") {
                saveFilters()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func saveFilters() {
        filter.country = country ? selectedCountry : nil
        filter.size = size ? selectedSize : nil
        filter.price = price ? selectedPrice : nil
    }
}

struct FilterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSelectionView(filter: .constant(Filter()))
    }
}
