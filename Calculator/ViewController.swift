//
//  ViewController.swift
//  Calculator
//
//  Created by albert jordan on 8/23/15.
//  Copyright (c) 2015 albert jordan. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var userIsTyping = false

    @IBOutlet weak var display: UITextField!
  

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if ( userIsTyping == false ) {
            userIsTyping = true
            display.text = digit
        } else {
            display.text =  display.text + digit

        }
        
    }
    
    
    @IBAction func operate(sender: UIButton) {
        
        if userIsTyping == true  {
            println("auto enter")

            enter()
        }
                
        switch sender.currentTitle! {
        case "+": performOperation { $0 + $1}
        case "-": performOperation { $1 - $0}
        case "*": performOperation { $0 * $1}
        case "%": performOperation { $1 % $0}
        case "√": performUniryOperation { sqrt($0)}

        default: break;
        }
        
        //operandStack.append(displayValue)
        
    }
    
    
    func performOperation(operation: (Double,Double)->Double) {
        if ( operandStack.count >= 2 ) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            println("auto enter")
            enter()

        }
    }
    
    func performUniryOperation(operation: Double -> Double) {
        if ( operandStack.count >= 1 ) {
            displayValue = operation(operandStack.removeLast())
            println("auto enter")

            enter()

        }
    }

    
    
    var operandStack = [Double]()
    
    @IBAction func enter() {
        userIsTyping = false
        operandStack.append(displayValue)
        println("\(operandStack)")
    }
    
    var displayValue:Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
}

