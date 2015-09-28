//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by albert jordan on 9/20/15.
//  Copyright © 2015 albert jordan. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op: CustomStringConvertible  {
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinayOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Operand(let num):
                        return "\(num)"
                case .UnaryOperation(let symbol, _ ):
                    return symbol
                case .BinayOperation(let symbol, _ ):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String: Op]()
    
    init() {
        knownOps["+"] = Op.BinayOperation("+",+)
        knownOps["-"] = Op.BinayOperation("-",-)
        knownOps["*"] = Op.BinayOperation("*")  { $0 * $1}
        knownOps["%"] = Op.BinayOperation("%")  { $1 % $0}
        knownOps["√"] = Op.UnaryOperation("√",sqrt)
        
    }
    
    func pushOperand(operand:Double) ->Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
        
    }
    
    private func evaluate( ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let temp = evaluate(remainingOps)
                if let operand = temp.result {
                    return(operation(operand),temp.remainingOps)
                }                
            case .BinayOperation(_ , let operation):
                let temp = evaluate(remainingOps)
                if let operand1 = temp.result {
                    let temp2 = evaluate(temp.remainingOps)
                    if let operand2 = temp2.result {
                        return (operation(operand1,operand2),temp2.remainingOps)
                    }
                }
                
            }
            
        }
        
        return (nil,ops)
    }
    
    func evaluate() -> Double?
    {
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with remainder \(remainder)")
        
        return result
    }
}
