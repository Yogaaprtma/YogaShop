//
//  HomeViewModel.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 30/01/24.
//

import SwiftUI

// Using Combine to monitor search field and if user leaves for .5 secs then starts searching...
// to avoid memory issue...
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var productType: ProductType = .Motor
    
    // Sample Products...
    @Published var products: [Product] = [
    
        Product(type: .Motor, title: "CBR 150R", subtitle: "Honda", price: "Rp.40.000.000", productImage: "CBR150"),
        Product(type: .Motor, title: "CBR 250R", subtitle: "Honda", price: "Rp.88.000.000", productImage: "CBR250"),
        Product(type: .Motor, title: "R15", subtitle: "Yamaha", price: "Rp.38.000.000", productImage: "R15"),
        Product(type: .Motor, title: "R25", subtitle: "Yamaha", price: "Rp.58.000.000", productImage: "R25"),
        Product(type: .Motor, title: "Gsx 150", subtitle: "Suzuki", price: "Rp.38.000.000", productImage: "Gsx150"),
        Product(type: .Motor, title: "ZX25R", subtitle: "Ninja", price: "Rp.120.000.000", productImage: "ZX25R"),
        Product(type: .Helm, title: "KYT TT Course", subtitle: "KYT", price: "Rp.1.200.000", productImage: "KYT"),
        Product(type: .Helm, title: "NJS ZX1", subtitle: "NJS", price: "Rp.800.000", productImage: "NJS"),
        Product(type: .Helm, title: "AGV Pista", subtitle: "AGV", price: "Rp.3.000.000", productImage: "AGV"),
        Product(type: .Helm, title: "RSV Ffc21", subtitle: "RSV", price: "Rp.2.000.000", productImage: "RSV"),
        Product(type: .Helm, title: "Zeus ZS826", subtitle: "Zeus", price: "Rp.1.500.000", productImage: "Zeus"),
        Product(type: .Helm, title: "Shoei X14 Marquez6", subtitle: "Shoei", price: "Rp.14.900.000", productImage: "Shoei"),
        Product(type: .Sparepart, title: "Knalpot WRX GP5 V2", subtitle: "WRX", price: "Rp.1.348.000", productImage: "Wrx"),
        Product(type: .Sparepart, title: "Master rem RCB S1", subtitle: "RCB", price: "Rp.1.550.000", productImage: "RCB"),
        Product(type: .Sparepart, title: "Stang Bpro", subtitle: "Bpro", price: "Rp.400.000", productImage: "Bpro"),
        Product(type: .Sparepart, title: "Stabilizer Matris", subtitle: "Matris", price: "Rp.800.000", productImage: "Matris"),
        Product(type: .Sparepart, title: "Velg Enkei FG511", subtitle: "Enkei", price: "Rp.1.600.000", productImage: "Enkei"),
        Product(type: .Sparepart, title: "Kaliper RCB S Series", subtitle: "RCB Series", price: "Rp700.000", productImage: "Kaliper_RCB"),
        Product(type: .Aksesoris, title: "Visor Helm Iridium", subtitle: "Iridium", price: "Rp.500.000", productImage: "Iridium"),
        Product(type: .Aksesoris, title: "Spoiler Helm", subtitle: "Spoiler", price: "Rp.300.000", productImage: "Spoiler"),
        Product(type: .Aksesoris, title: "Intercom Ejeas Q7", subtitle: "Ejeas", price: "Rp.500.000", productImage: "Ejeas"),
        Product(type: .Aksesoris, title: "Undertail Motor", subtitle: "undertail", price: "Rp.180.000", productImage: "undertail"),
        Product(type: .Aksesoris, title: "Handgrip RCB", subtitle: "RCB", price: "Rp.90.000", productImage: "Handgrip_RCB"),
        Product(type: .Aksesoris, title: "Winglet CBR", subtitle: "Winglet", price: "Rp.80.000", productImage: "Winglet"),
    ]
    
    // Filtered Products...
    @Published var filteredProducts: [Product] = []
    
    // More Products On The Type...
    @Published var showMoreProductsOnType: Bool = false
    
    // Search Data...
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since It Will Require More Memory So Were Using Lazy To Perform More...
                .lazy
                .filter { product in
                    
                    return product.type == self.productType
                }
            // Limiting Result...
                .prefix(6)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since It Will Require More Memory So Were Using Lazy To Perform More...
                .lazy
                .filter { product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
