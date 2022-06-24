//
//  File.swift
//  
//
//  Created by rise on 24.06.22.
//

import Foundation

extension AnyHashable {
    func toString() -> String {
        if let string = self as? String {
            return string
        }
        return ""
    }
}
