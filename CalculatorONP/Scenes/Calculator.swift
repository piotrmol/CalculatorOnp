//
//  Calculator.swift
//  CalculatorONP
//
//  Created by Piotr Mol on 09/06/2020.
//  Copyright © 2020 Piotr Mol. All rights reserved.
//

import SwiftUI

struct Calculator: View {
    @ObservedObject var viewModel = CalculatorViewModelImpl()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            CalculatorTextField(text: $viewModel.expression, placeholder: "Expression")
            CalculatorTextField(text: $viewModel.onpExpression, placeholder: "ONP")
            CalculatorTextField(text: $viewModel.onStack, placeholder: "Values on stack")
            CalculatorTextField(text: $viewModel.result, placeholder: "Result")
            ForEach(viewModel.operands, id: \.self) { row in
                HStack(alignment: .center, spacing: 4.0){
                    ForEach(row, id: \.self) { element in
                        Button(action: {
                            self.viewModel.addNext(char: element)
                        }) {
                            HStack {
                                Spacer()
                                Text(String(element))
                                    .foregroundColor(Color.black)
                                Spacer()
                            }
                        }
                        .padding()
                        .background(element.isNumber ? Color.purple : Color.gray)
                        .cornerRadius(5)
                    }
                }
                .padding([.leading, .trailing])
            }
            Spacer()
        }
        .padding([.top])
    }
}

#if DEBUG
struct Calculator_Previews: PreviewProvider {
    static var previews: some View {
        Calculator()
    }
}
#endif
