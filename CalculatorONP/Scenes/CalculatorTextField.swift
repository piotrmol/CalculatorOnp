//
//  CalculatorTextField.swift
//  CalculatorONP
//
//  Created by Piotr Mol on 12/06/2020.
//  Copyright © 2020 Piotr Mol. All rights reserved.
//

import SwiftUI

struct CalculatorTextField: View {
    
    @Binding var text: String
    let placeholder: String
    
    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }
    
    var body: some View {
        TextField(placeholder, text: $text)
            .border(Color.gray, width: 2)
            .padding([.leading, .trailing, .bottom])
            .multilineTextAlignment(.leading)
    }
    
}
