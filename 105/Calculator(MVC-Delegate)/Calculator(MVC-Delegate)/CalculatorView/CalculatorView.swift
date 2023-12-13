//
//  CalculatorView.swift
//  Calculator(MVC-Delegate)
//
//  Created by Евгений Борисов on 17.11.2023.
//

import UIKit

class CalculatorView: UIView {
    
    weak var calculatorController: CalculatorController?
    
    private lazy var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.text = "0"
        resultLabel.textColor = .white
        resultLabel.font = UIFont.systemFont(ofSize: 64)
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textAlignment = .right
        return resultLabel
    }()
    
    private lazy var oneButton = CalculatorButton(color: .darkGray, text: "1")
    private lazy var twoButton = CalculatorButton(color: .darkGray, text: "2")
    private lazy var threeButton = CalculatorButton(color: .darkGray, text: "3")
    private lazy var fourButton = CalculatorButton(color: .darkGray, text: "4")
    private lazy var fiveButton = CalculatorButton(color: .darkGray, text: "5")
    private lazy var sixButton = CalculatorButton(color: .darkGray, text: "6")
    private lazy var sevenButton = CalculatorButton(color: .darkGray, text: "7")
    private lazy var eightButton = CalculatorButton(color: .darkGray, text: "8")
    private lazy var nineButton = CalculatorButton(color: .darkGray, text: "9")
    private lazy var zeroButton = CalculatorButton(color: .darkGray, text: "0")
    private lazy var divisionButton = CalculatorButton(color: .systemOrange, text: "÷", operation: .division)
    private lazy var multiplyButton = CalculatorButton(color: .systemOrange, text: "x", operation: .multy)
    private lazy var substractButton = CalculatorButton(color: .systemOrange, text: "—", operation: .minus)
    private lazy var appendButton = CalculatorButton(color: .systemOrange, text: "+", operation: .plus)
    
    private lazy var clearButton = {
        let button = CalculatorButton(color: .lightGray, text: "A/C")
        let clearAtion = UIAction { _ in
            self.calculatorController?.didPressClearButton()
            self.resultLabel.text = "0"
        }
        button.addAction(clearAtion, for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton = {
        let button = CalculatorButton(color: .lightGray, text: "+/-")
        let signAction = UIAction { _ in
            
            var text = self.resultLabel.text!
            
            if text == "0" { return }
            
            if text.hasPrefix("-") {
                text.removeFirst()
            } else {
                text = "-" + text
            }
            
            self.resultLabel.text = text
        }
        
        button.addAction(signAction, for: .touchUpInside)
        return button
    }()
    private lazy var precentButton = CalculatorButton(color: .lightGray, text: "%")

    private lazy var equalButton = {
        let button = CalculatorButton(color: .systemOrange, text: "=")
        
        let action = UIAction { _ in
            self.calculatorController?.didPressEqualButton(currentNumber: self.resultLabel.text!)
            self.resultLabel.text = self.calculatorController?.getResult()
        }
        
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    private lazy var commaButton = CalculatorButton(color: .darkGray, text: ",")
    
    private lazy var firstButtonRow = CalculatorRowButtonStackView(buttons: [
        clearButton,
        minusButton,
        precentButton,
        divisionButton
    ])
    
    private lazy var secondButtonRow = CalculatorRowButtonStackView(buttons: [
        sevenButton,
        eightButton,
        nineButton,
        multiplyButton
    ])
    
    private lazy var thirdButtonRow = CalculatorRowButtonStackView(buttons: [
        fourButton,
        fiveButton,
        sixButton,
        substractButton
    ])
    
    private lazy var fourthButtonRow = CalculatorRowButtonStackView(buttons: [
        oneButton,
        twoButton,
        threeButton,
        appendButton
    ])
    
    private lazy var fifthButtonRow = CalculatorRowButtonStackView(buttons: [
        zeroButton,
        commaButton,
        equalButton,
    ])
    
    private lazy var numberButtons = [
        oneButton,
        twoButton,
        threeButton,
        fourButton,
        fiveButton,
        zeroButton,
        sixButton,
        sevenButton,
        eightButton,
        nineButton
    ]
    
    private lazy var operationButtons = [
        divisionButton,
        multiplyButton,
        substractButton,
        appendButton
    ]
    
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 15
        buttonsStackView.addArrangedSubview(firstButtonRow)
        buttonsStackView.addArrangedSubview(secondButtonRow)
        buttonsStackView.addArrangedSubview(thirdButtonRow)
        buttonsStackView.addArrangedSubview(fourthButtonRow)
        buttonsStackView.addArrangedSubview(fifthButtonRow)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsStackView
    }()
    

    
    private var isCalculating = false
    
  

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActions() {
        for button in numberButtons {
            button.addTarget(self, action: #selector(oneButtonTapped(sender:)), for: .touchUpInside)
        }
        
        for operationButton in operationButtons {
            operationButton.addTarget(self, action: #selector(operationButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    
    @objc func oneButtonTapped(sender: UIButton) {
            
        if !isCalculating && resultLabel.text != "0" {
            resultLabel.text! += sender.titleLabel!.text!
        } else {
            resultLabel.text = sender.titleLabel!.text!
        }
        
        isCalculating = false
    }
    
    @objc func operationButtonTapped(sender: CalculatorButton) {
        isCalculating = true
        calculatorController?.didPressOperationButton(operation: sender.operation!, currentNumber: resultLabel.text!)
        resultLabel.text = calculatorController?.getResult()
    }
    
    private func setupView() {
        backgroundColor = .black
        addSubview(resultLabel)
        addSubview(buttonsStackView)
        setupLayout()
    }
    
    private func setupLayout() {
        
        let margin: CGFloat = 15
        
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            buttonsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -margin),
        ])
        
        NSLayoutConstraint.activate([
            resultLabel.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -margin),
            resultLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            resultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin)
        ])
        
        
    }
    
}
