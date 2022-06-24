//
//  SelectionModifier.swift
//  
//
//  Created by rise on 24.06.22.
//

import Foundation
import SwiftUI

struct SelectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .shadow(radius: 10)
    }
}

extension View {
    @ViewBuilder
    func selectable(active: Bool) -> some View {
        if active {
            self.modifier(SelectionModifier())
        } else {
            self
        }
    }
}
