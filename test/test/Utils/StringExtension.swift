//
//  Utils.swift
//  test
//
//  Created by Adrian Aguilar on 29/3/25.
//

import Foundation
extension String {
    var isNotEmpty: Bool {
        return !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        return self.allSatisfy { $0.isNumber } && self.count >= 10
    }
    
}
