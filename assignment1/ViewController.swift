//
//  ViewController.swift
//  assignment1
//
//  Created by Arturo Lopez on 9/13/15.
//  Copyright (c) 2015 Arturo Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userMiddleTypingNum = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userMiddleTypingNum {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userMiddleTypingNum = true
        }

    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userMiddleTypingNum{
            enter()
        }
        switch operation {
            case "×":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() * operandStack.removeLast()
                    enter()
                }
                
//            case "÷":
//            case "+":
//            case "−":
            default: break
        }
        
        
    }
    
    var operandStack = Array<Double>()

    
    @IBAction func enter() {
        userMiddleTypingNum = false
        operandStack.append(displayValue)
        println("operaandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userMiddleTypingNum = false
        }
    }
}

