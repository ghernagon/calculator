//
//  ViewController.swift
//  Calculator
//
//  Created by Gerardo Hernández on 3/6/16.
//  Copyright © 2016 Gerardo Hernández. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingNumber: Bool = false
    
    //var operandStack: Array<Double> = Array<Double>()
    
    var brain = CalculatorBrain()
    
    //Computed properties
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        print("digit = \(digit)")
        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
//        operandStack.append(displayValue)
//        print("operandStack = \(operandStack)")
        
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        } else {
            displayValue = 0
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        
        //Ways of closures
//        switch operation { //Closures
//        case "×": performOperation({ (op1, op2) in return op1 * op2 })
//        case "÷": performOperation({ (op1, op2) in return op1 / op2 })
//        case "+": performOperation({ (op1, op2) in return op1 + op2 })
//        case "−": performOperation({ (op1, op2) in return op1 - op2 })
//        default: break
//            
//        }
//        
//        //OR
//        switch operation { //Closures
//        case "×": performOperation({ (op1, op2) in op1 * op2 })
//        case "÷": performOperation({ (op1, op2) in op1 / op2 })
//        case "+": performOperation({ (op1, op2) in op1 + op2 })
//        case "−": performOperation({ (op1, op2) in op1 - op2 })
//        default: break
//            
//        }
        
//        //OR
//        switch operation { //Closures
//        case "×": performOperation({ $0 * $1 })
//        case "÷": performOperation({ $0 / $1 })
//        case "+": performOperation({ $0 + $1 })
//        case "−": performOperation({ $0 - $1 })
//        default: break
//            
//        }
        
        //OR
//        switch operation { //Closures - Cause this is the last argument
//        case "×": performOperation { $0 * $1 }
//        case "÷": performOperation { $1 / $0 }
//        case "+": performOperation { $0 + $1 }
//        case "−": performOperation { $1 - $0 }
//        case "√": performOperation { sqrt($0) }
//        default: break
        
//        }
        
    }
    
//    //Type method
//    private func performOperation(operation: (Double, Double) -> Double) {
//        if operandStack.count >= 2 {
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//    }
//    //Same type method but arguments
//    private func performOperation(operation: Double -> Double) {
//        if operandStack.count >= 1 {
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

