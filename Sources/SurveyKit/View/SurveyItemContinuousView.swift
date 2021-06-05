//
//  SurveyItemContinuousView.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 05.06.21.
//

import SwiftUI

public struct SurveyItemContinuousView<I: SurveyItem>: SurveyItemView {
    typealias Item = I
    var index: Int
    var item: Item
    var leadingText: String = ""
    var trailingText: String = ""
    var didEnterAnswer: ((String) -> ())?
    @State var value: Double = 0.0
    @State var selectedValue: Double = 0
    var displayValue: Int {
        Int(exactly: self.selectedValue) ?? 0
    }
    public var body: some View {
        LazyVStack(alignment: .leading) {
            Text("\(index). \(item.text)")
                .fontWeight(.bold)
                .font(.headline)
            Slider(value: $value, in: item.minimum...item.maximum)
                .onChange(of: self.value, perform: { value in
                    self.didEnterAnswer?(String(format: "%1f", value))
                })
                .shadow(radius: 4)
            HStack {
                Spacer()
                Text("\(value, specifier: "%.1f")")
                    .font(.body)
                Spacer()
            }
            
        }
    }
}

struct SurveyItemContinuousView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleItem = SimpleSurveyItem(text: "Hallo", format: .Continuous, minimum: 0, maximum: 10)
        SurveyItemContinuousView<SimpleSurveyItem>(index: 0,
                                 item: exampleItem
        )
    }
}
