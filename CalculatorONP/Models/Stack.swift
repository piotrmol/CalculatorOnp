//
//  Stack.swift
//  CalculatorONP
//
//  Created by Piotr Mol on 09/06/2020.
//  Copyright © 2020 Piotr Mol. All rights reserved.
//

import Foundation

struct Stack<Element> {
    
    private var array: [Element] = []
    
    var isEmpty: Bool {
        return array.isEmpty
    }

    var count: Int {
        return array.count
    }
    
    var valuesOn: [Element] {
        return array
    }
  
    mutating func push(_ element: Element) {
        array.append(element)
    }

    mutating func pop() -> Element? {
        return array.popLast()
    }
    
    mutating func drop() {
        array.removeAll()
    }

    func peek() -> Element? {
        return array.last
    }
    
}
