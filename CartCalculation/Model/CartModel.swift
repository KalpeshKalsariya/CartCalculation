//
//  CartModel.swift
//  CartCalculation
//
//  Created by  Kalpesh on 01/06/24.
//

import Foundation

struct Product {
    var price: Float
    var taxRate: Float
}

struct DiscountInfo {
    var discountAmount: Float
    var discountPercentage: Float
    var maximumDiscountAmount: Float
    var usePercentage: Bool
}

struct CartItem {
    var product: Product
    var discountInfo: DiscountInfo?
    var attributePrice: Float
    var quantity: Int
}
