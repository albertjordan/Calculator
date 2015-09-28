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
    
    var brain = CalculatorBrain()

    @IBOutlet weak var display: UITextField!
  

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if ( userIsTyping == false ) {
            userIsTyping = true
            display.text = digit
        } else {
            display.text =  display.text! + digit

        }
        
    }
    
    
    @IBAction func operate(sender: UIButton) {
        if userIsTyping {
            enter()
        }
        if let operation  = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
        
    }
    
    
    
    @IBAction func enter() {
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        userIsTyping = false
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

