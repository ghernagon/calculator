//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Gerardo Hernández on 3/8/16.
//  Copyright © 2016 Gerardo Hernández. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    
    private var opSatck = [Op]() //Array<Op>()
    
    private var knownOps = [String:Op]() //Dictionary
    
    init() {
        knownOps["×"] = Op.BinaryOperation("×", {$0 * $1} )
        knownOps["÷"] = Op.BinaryOperation("÷", {$1 / $0} )
        knownOps["+"] = Op.BinaryOperation("+", {$0 + $1} )
        knownOps["−"] = Op.BinaryOperation("−", {$1 - $0} )
        knownOps["√"] = Op.UnaryOperation("√", { sqrt($0) } )
    }
    
    func pushOperand(operand: Double) -> Double? {
        opSatck.append(Op.Operand(operand))
        return evaluate()!
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opSatck.append(operation)
        }
        return evaluate()
    }
    
    //Recursive function
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opSatck)
        print("\(opSatck) = \(result) with \(remainder) left over")
        return result
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        
        return (nil, ops)
    }
    
}