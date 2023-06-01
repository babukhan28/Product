//
//  ProductModel.swift
//  Product
//
//  Created by Rajni on 05/05/23.
//

import Foundation

struct ProductModel: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Decodable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

struct Rating: Decodable {
    let rate: Double
    let count: Int
}

