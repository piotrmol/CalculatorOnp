//
//  CalculatorViewModel.swift
//  CalculatorONP
//
//  Created by Piotr Mol on 09/06/2020.
//  Copyright © 2020 Piotr Mol. All rights reserved.
//

import SwiftUI

class CalculatorViewModelImpl: ObservableObject {
    
    @Published var expression = ""
    @Published var onpExpression = ""
    @Published var result = ""
    @Published var onStack = ""
    
    var operands: [[Character]] = [
        ["1", "2", "3", "C"],
        ["4", "5", "6", "="],
        ["7", "8", "9", "0"],
        ["+", "-", "*", "/"],
        ["^",".", "(", ")"]
    ]
    
    private let _operands: [Character: Int] = ["(": 0, ")": 0, "+": 1, "-": 1, "*": 2, "/": 2, "^": 3, "=": -1, "C": -1]
    private var stack = Stack<Character>() {
        didSet {
            onStack = stack.valuesOn.map { String($0) }
                                    .reduce("", +)
        }
    }
        
    func addNext(char: Character) {
        expression.append(char)
        
        if "0"..."9" ~= char || char == "." {
            onpExpression.append(char)
            return
        }
        
        switch char {
        case "(":
            stack.push(char)
        case ")":
            popInnerSymbols()
        case "C":
            clear()
        case "=":
            calculate()
        default:
            check(symbol: char)
        }
    }
    
    private func popInnerSymbols() {
        var symbol = stack.pop()
        while symbol != "(" {
            if let sym = symbol {
                onpExpression.append(sym)
            }
            symbol = stack.pop()
            if stack.isEmpty {
                break
            }
        }
    }
    
    private func clear() {
        onpExpression = ""
        expression = ""
        result = ""
        stack.drop()
    }
    
    private func check(symbol: Character){
        if onpExpression.last != " " { // Adding space to mark end of number
            onpExpression.append(" ")
        }
        if var fromStack = stack.peek() {
            while _operands[fromStack] > _operands[symbol] {
                guard let symbol = stack.pop() else { break }
                onpExpression.append(symbol)
                fromStack = stack.peek() ?? Character("")
            }
        }
        stack.push(symbol)
    }
    
    private func calculate() {
        if !stack.isEmpty {
            onpExpression.append(" ")
        }
        while !stack.isEmpty {
            guard let symbol = stack.pop() else { break }
            onpExpression.append(symbol)
        }
        
        var stringNumber = ""
        var stack = Stack<Double>()
        for char in onpExpression {
            if "0"..."9" ~= char || char == "." {
                stringNumber.append(char)
                continue
            }
            if let number = Double(stringNumber) {
                stack.push(number)
                stringNumber = ""
            }
            switch char {
            case " ":
                continue
            case "+":
                if let lhs = stack.pop(), let rhs = stack.pop() {
                    stack.push(rhs + lhs)
                }
            case "-":
                if let lhs = stack.pop(), let rhs = stack.pop() {
                    stack.push(rhs - lhs)
                }
            case "*":
                if let lhs = stack.pop(), let rhs = stack.pop() {
                    stack.push(rhs * lhs)
                }
            case "/":
                if let lhs = stack.pop(), let rhs = stack.pop() {
                    stack.push(rhs / lhs)
                }
            case "^":
                if let lhs = stack.pop(), let rhs = stack.pop() {
                    stack.push(pow(rhs, lhs))
                }
            default:
                result = "Error, expression is invalid"
                return
            }
        }
        self.result = stack.pop()?.description ?? ""
    }
        
}

fileprivate func > <T:Comparable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs > rhs
    }
    return lhs != nil
}
    




