//
//  Product.swift
//  YogaShop
//
//  Created by Yoga Adi Pratama on 30/01/24.
//

import SwiftUI

// Product Model...
struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}

// Product Types...
enum ProductType: String, CaseIterable{
    case Motor = "Motor"
    case Helm = "Helm"
    case Sparepart = "Sparepart"
    case Aksesoris = "Aksesoris"
}
