//
//  CommonExtensions.swift
//  ECommerceSample
//
//  Created by Pratik on 20/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
    static let rankingArray = CodingUserInfoKey(rawValue: "rankingArray")
}

extension Int {
    ///Convert int to number
    var toNumber : NSNumber? {
        let data = NSNumber(value: self)
        return data
    }
}

extension String {
    var toTrim : String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
extension Double {
    var removeZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
