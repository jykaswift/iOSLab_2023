//
//  Calculator.swift
//  Calculator(MVC-Delegate)
//
//  Created by Евгений Борисов on 17.11.2023.
//

import Foundation


class Calculator {
    private var result: Int?
    private var currentNumber = 0
    private var operation: Operation?
    
    
    func setCalculatorParamsWith(operation: Operation?) {
        self.operation = operation
        
    }
    
    func setCurrentNumber(withStringNumber number: String) {
        currentNumber = Int(number) ?? 0
    }
    
    func calculate() {
        if result == nil {
            result = currentNumber
            return
        }
        
        switch operation {
        case .minus:
            result! -= currentNumber
        case .plus:
            result! += currentNumber
        case .multy:
            result! *= currentNumber
        case .division:
            result! /= currentNumber
        default:
            return
        }
        
    }
    
    func getStringResult() -> String {
        return String(result!)
    }
    
    func reset() {
        result = nil
        currentNumber = 0
        operation = nil
    }
    
}
