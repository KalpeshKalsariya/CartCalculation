//
//  ViewController.swift
//  CartCalculation
//
//  Created by  Kalpesh on 01/06/24.
//

import UIKit

class ViewController: UIViewController {

    var ci = CartCalculatedValue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let value: Float = 14.07501
        let roundedValue = value.roundAllAmountKK()
        print("System round function: \(roundedValue)\n")
        print("Manual round function: \(value.roundAllAmount())\n")
        
        // Example usage
        let product1 = Product(price: 4, taxRate: 8.25)
        let discountInfo1 = DiscountInfo(discountAmount: 0, discountPercentage: 50, maximumDiscountAmount: 0, usePercentage: true)
        let cartItem1 = CartItem(product: product1, discountInfo: discountInfo1, attributePrice: 3.0, quantity:1)

        let product2 = Product(price: 200.0, taxRate: 4.5)
        let discountInfo2 = DiscountInfo(discountAmount: 10.0, discountPercentage: 20.0, maximumDiscountAmount: 25.0, usePercentage: false)
        let cartItem2 = CartItem(product: product2, discountInfo: discountInfo2, attributePrice: 30.0, quantity: 1)

        let cartItems = [cartItem1, cartItem2]

        calculateCartAmountForProduct(cartItems: cartItems)
        
        calculateCartAmountForOrder(cartItems: cartItems)
    }

    func getAttributeTotalPriceForPerProduct(ci: CartItem) -> Float {
        return ci.attributePrice
    }

    func calculateCartAmountForProduct(cartItems: [CartItem]) {
        // Define the variables
        var subTotal: Float = 0
        var taxAsPerProduct: Float = 0
        var orderTotal: Float = 0.0
        var cartDiscount: Float = 0.0
        
        // Iterate over each product in the cart
        for tempCi in cartItems {
            // Define the constants
            let productPrice: Float = tempCi.product.price // Product price without attribute
            let attributePrice: Float = getAttributeTotalPriceForPerProduct(ci: tempCi) // attribute price
            let discountAmount: Float = Float(tempCi.discountInfo?.discountAmount ?? 0.0) // flat discount amount
            let discountPercentage: Float = Float(tempCi.discountInfo?.discountPercentage ?? 0.0) // discount percentage
            let maxDiscountAmount: Float = Float(tempCi.discountInfo?.maximumDiscountAmount ?? 0.0) // maximum discount amount
            let taxRate: Float = tempCi.product.taxRate // tax rate
            let quantity: Int = tempCi.quantity // quantity
            
            // Step 1: Calculate the product price including attributes
            let totalPrice = productPrice + attributePrice
            
            // Step 2: Calculate the discount based on flat or percentage
            var productDiscount: Float = 0
            if tempCi.discountInfo?.usePercentage == true {
                // Percentage Discount Calculation
                var calculatedDiscount = (totalPrice * discountPercentage) / 100
                if maxDiscountAmount > 0 {
                    if calculatedDiscount > maxDiscountAmount {
                        calculatedDiscount = maxDiscountAmount
                    }
                }
                productDiscount = calculatedDiscount
            } else {
                // Flat Discount Calculation
                productDiscount = discountAmount
            }
            
            // Step 3: Calculate cart discount
            cartDiscount += productDiscount
            
            // Step 4: Calculate the discounted price
            let discountedPrice = totalPrice - productDiscount
            
            // Step 5: Calculate the product tax
            let productTax = (discountedPrice * taxRate) / 100
            
            // Step 6: Calculate the total tax amount
            taxAsPerProduct += productTax * Float(quantity)
            
            // Step 7: Calculate the subtotal amount
            subTotal += discountedPrice * Float(quantity)
        }
        
        // Step 8: Calculate the total amount
        orderTotal = subTotal + taxAsPerProduct
        
        ci.subTotalAmount = subTotal
        ci.discountAmount = cartDiscount
        ci.taxRate = taxAsPerProduct
        ci.orderTotalAmount = orderTotal
        
        // Printing the final results
        print("Subtotal: \(ci.subTotalAmount.roundAllAmount())")
        print("Tax: \(ci.taxRate.roundAllAmount())")
        print("Discount: \(ci.discountAmount.roundAllAmount())")
        print("Order Total: \(ci.orderTotalAmount.roundAllAmount())\n")
    }
    
    func calculateCartAmountForOrder(cartItems: [CartItem]) {
        // Define the variables
        var subTotal: Float = 0
        var taxAsPerProduct: Float = 0
        var orderTotal: Float = 0.0
        var cartDiscount: Float = 0.0
        
        // Iterate over each product in the cart
        for tempCi in cartItems {
            // Define the constants
            let productPrice: Float = tempCi.product.price // Product price without attribute
            let attributePrice: Float = getAttributeTotalPriceForPerProduct(ci: tempCi) // attribute price
            let discountAmount: Float = Float(tempCi.discountInfo?.discountAmount ?? 0.0) // flat discount amount
            let discountPercentage: Float = Float(tempCi.discountInfo?.discountPercentage ?? 0.0) // discount percentage
            let maxDiscountAmount: Float = Float(tempCi.discountInfo?.maximumDiscountAmount ?? 0.0) // maximum discount amount
            let taxRate: Float = tempCi.product.taxRate // tax rate
            let quantity: Int = tempCi.quantity // quantity
            
            // Step 1: Calculate the product price including attributes
            let totalPrice = (productPrice + attributePrice) * Float(quantity)
            
            // Step 2: Calculate the tax
            let productTax = (totalPrice * taxRate) / 100
            
            // Step 3: Calculate the total tax amount
            taxAsPerProduct += productTax
            
            // Step 4: Calculate the subtotal amount
            subTotal += totalPrice
            
            orderTotal = totalPrice + productTax
            
            // Step 5: Calculate the discount based on flat or percentage
            var productDiscount: Float = 0
            if tempCi.discountInfo?.usePercentage == true {
                // Percentage Discount Calculation
                var calculatedDiscount = (orderTotal * discountPercentage) / 100
                if maxDiscountAmount > 0 {
                    if calculatedDiscount > maxDiscountAmount {
                        calculatedDiscount = maxDiscountAmount
                    }
                }
                productDiscount = calculatedDiscount
            } else {
                // Flat Discount Calculation
                productDiscount = discountAmount
            }
            
            // Step 6: Calculate cart discount
            cartDiscount += productDiscount
        }
        
        // Step 7: Calculate the total amount
        orderTotal = orderTotal - cartDiscount
        
        ci.subTotalAmount = subTotal
        ci.discountAmount = cartDiscount
        ci.taxRate = taxAsPerProduct
        ci.orderTotalAmount = orderTotal
        
        // Printing the final results
        print("Subtotal: \(ci.subTotalAmount.roundAllAmount())")
        print("Tax: \(ci.taxRate.roundAllAmount())")
        print("Discount: \(ci.discountAmount.roundAllAmount())")
        print("Order Total: \(ci.orderTotalAmount.roundAllAmount())")
        
    }
}
