//
//  Products.swift
//  OnlineStore
//
//  Created by dev on 3/12/23.
//

import Foundation

// MARK: - Welcome
struct ProductModel: Codable, Identifiable {
    var id : Int?
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable , Identifiable{
    let id: Int?
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
}
