//
//  ViewController.swift
//  iBrain
//
//  Created by mevlüt can gündoğan on 5.05.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var prevAns: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var answerTxt: UITextField!
    @IBOutlet weak var questionTxt: UILabel!
    let happySound : SystemSoundID = 1054
    let sadSound : SystemSoundID = 1053
    var correctAnswer: Int = 0
    var mistakeCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        correctAnswer = questUpdate()
        
    }

    @IBAction func CheckAnswer(_ sender: Any) {
        let answer: Int? = Int(answerTxt.text ?? "")
    
        if answer == correctAnswer{
            AudioServicesPlaySystemSound(happySound)
            score.text = String(Int(score.text!)! + 1)
            prevAns.backgroundColor = UIColor.systemGreen
            
            mistakeCount = 0
            correctAnswer = questUpdate()
        }
        else {
            AudioServicesPlaySystemSound(sadSound)
            score.text = String(Int(score.text!)! - 1)
            prevAns.backgroundColor = UIColor.systemOrange
            
            mistakeCount += 1
        }
        
        prevAns.text = answerTxt.text
        answerTxt.text = nil
        
        if(mistakeCount == 3){
            mistakeCount = 0
            prevAns.text = String(correctAnswer)
            prevAns.backgroundColor = UIColor.systemRed
            correctAnswer = questUpdate()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
        
    }
    
    func questUpdate() -> Int{
        let termCount = Int.random(in: 2..<6)
        //let termCount = 2
        var terms = [Int](repeating: 0, count: termCount)
        for i in 0..<terms.count{
            terms[i] = Int.random(in: 0..<1000)
        }
        
        var operators = [Character](repeating: "+", count: termCount-1)
        let opChars: [Character] = ["+", "-"]
        for i in 0..<operators.count{
            operators[i] = opChars[Int.random(in: 0..<opChars.count)]
        }
        
        var qString: String = ""
        
        for i in 0..<termCount-1{
            qString.append(String(terms[i]))
            qString.append(String(operators[i]))
        }
            qString.append(String(terms[termCount-1]))
        
        questionTxt.text = qString
        
        var result = terms[0]
        
        for (ix,op) in operators.enumerated() {
            switch op {
            case "+":
                result += terms[ix+1]
            case "-":
                result -= terms[ix+1]
            case "/":
                result /= terms[ix+1]
            case "x":
                result *= terms[ix+1]
            default:
                print("Error, no such operation as /(op)")
            }
        }
        
        return result
    }
    
    
}

