//
//  ViewController.swift
//  Calculator(MVC-Delegate)
//
//  Created by Евгений Борисов on 17.11.2023.
//

import UIKit

protocol CalculatorController: AnyObject {
    func didPressOperationButton(operation: Operation, currentNumber: String)
    func didPressEqualButton(currentNumber: String)
    func didPressClearButton()
    func getResult() -> String
}

class CalculatorViewController: UIViewController {
    
    private var calculator = Calculator()
    lazy var calculatorView = CalculatorView(frame: .zero)
    
    override func loadView() {
        view = calculatorView
        calculatorView.calculatorController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

// MARK: Calculator Controller
extension CalculatorViewController: CalculatorController {
    func didPressOperationButton(operation: Operation, currentNumber: String) {
        calculator.setCurrentNumber(withStringNumber: currentNumber)
        calculator.calculate()
        calculator.setCalculatorParamsWith(operation: operation)
    }
    
    func getResult() -> String {
        calculator.getStringResult()
    }
    
    func didPressEqualButton(currentNumber: String) {
        calculator.setCurrentNumber(withStringNumber: currentNumber)
        calculator.calculate()
        calculator.setCalculatorParamsWith(operation: nil)
    }
    
    func didPressClearButton() {
        calculator.reset()
    }
}
