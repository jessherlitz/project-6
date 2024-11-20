//
// CurrencyConverter.swift
//  project-6
//
//  Created by Jessica Sampaio-Herlitz on 11/20/24.

import Foundation

struct CurrencyConverter {
    let conversionRates: [String: Double] = [
        "EUR": 0.94,
        "GBP": 0.79,
        "CAD": 1.40,
        "BRL": 5.77
    ]

    func convert(amount: Double, forCurrencies currencies: [String]) -> [String: Double] {
        var results: [String: Double] = [:]
        for currency in currencies {
            if let rate = conversionRates[currency] {
                results[currency] = amount * rate
            }
        }
        return results
    }
}
