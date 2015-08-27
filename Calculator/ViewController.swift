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
    
    //test
    
    @IBAction func operate(sender: UIButton) {
        
        let op1 = operandStack.removeLast();
        let op2 = operandStack.removeLast();
        
        switch sender.currentTitle! {
        case "+":
            displayValue = op1 + op2
            break
        case "-":
            displayValue = op2 - op1
            break
        case "*":
            displayValue = op2*op1
            break
        case "%":
            displayValue = op2/op1
            break
        default:
            break;
        }
        
        operandStack.append(displayValue)
        
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

