//
//  ViewController.swift
//  Calculator
//
//  Created by 张子雄 on 5/18/20.
//  Copyright © 2020 张子雄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder: UIView!
    
    var firstNum = 0.0
    var resultNum = 0.0
    var nextNum = 0
    var currentOperation: Operations?
    enum Operations {
        case divide, multiply, substract, add
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name:"Arial", size: 40)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNumberPad()
    }
    private func setupNumberPad(){
        let buttonSize = view.frame.size.width / 4
        
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*2, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.tag = 1
        zeroButton.setTitle("0", for: .normal)
        zeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        let dotButton = UIButton(frame: CGRect(x: buttonSize*2, y: holder.frame.size.height-buttonSize, width: buttonSize, height: buttonSize))
        dotButton.setTitleColor(.black, for: .normal)
        dotButton.backgroundColor = .white
        dotButton.tag = 11
        dotButton.setTitle(".", for: .normal)
        dotButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(dotButton)
        
        for x in 0..<3{
            let otherButton = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-2*buttonSize, width: buttonSize, height: buttonSize))
            otherButton.setTitleColor(.black, for: .normal)
            otherButton.backgroundColor = .white
            otherButton.tag = x+2
            otherButton.setTitle("\(x+1)", for: .normal)
            otherButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(otherButton)
        }
        for x in 0..<3{
            let otherButton2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-3*buttonSize, width: buttonSize, height: buttonSize))
            otherButton2.setTitleColor(.black, for: .normal)
            otherButton2.backgroundColor = .white
            otherButton2.tag = x+5
            otherButton2.setTitle("\(x+4)", for: .normal)
            otherButton2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(otherButton2)
        }
        for x in 0..<3{
            let otherButton3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-4*buttonSize, width: buttonSize, height: buttonSize))
            otherButton3.setTitleColor(.black, for: .normal)
            otherButton3.backgroundColor = .white
            otherButton3.tag = x+8
            otherButton3.setTitle("\(x+7)", for: .normal)
            otherButton3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(otherButton3)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-5*buttonSize, width: buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.setTitle("C", for: .normal)//初始化是AC
        holder.addSubview(clearButton)
        
        let negButton = UIButton(frame: CGRect(x: buttonSize, y: holder.frame.size.height-5*buttonSize, width: buttonSize, height: buttonSize))
        negButton.setTitleColor(.black, for: .normal)
        negButton.backgroundColor = .white
        negButton.setTitle("+/-", for: .normal)
        holder.addSubview(negButton)
        negButton.addTarget(self, action: #selector(negPressed(_:)), for: .touchUpInside)
        
        let modButton = UIButton(frame: CGRect(x: buttonSize*2, y: holder.frame.size.height-5*buttonSize, width: buttonSize, height: buttonSize))
        modButton.setTitleColor(.black, for: .normal)
        modButton.backgroundColor = .white
        modButton.setTitle("%", for: .normal)
        holder.addSubview(modButton)
        modButton.addTarget(self, action: #selector(modPressed(_:)), for: .touchUpInside)
        
        let operation = ["/","*","-","+","="]
        for x in 0..<5{
            let opButton = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-buttonSize * CGFloat(x+1), width: buttonSize, height: buttonSize))
            opButton.setTitleColor(.black, for: .normal)
            opButton.backgroundColor = .orange
            opButton.setTitle(operation[4-x], for: .normal)
            opButton.tag = 5-x
            holder.addSubview(opButton)
            opButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        resultLabel.frame = CGRect(x: 0, y: holder.frame.size.height-buttonSize * CGFloat(6) , width: view.frame.size.width, height: 100)
        holder.addSubview(resultLabel)
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
    }
    
    @objc func clearResult() {
        resultLabel.text = "0"
        firstNum = 0.0
        nextNum = 0
    }
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        if nextNum == 1 {
            resultLabel.text = "0"
            nextNum = 0
        }
        if nextNum == 2 {
            clearResult()
        }
        if resultLabel.text == "0" {
            if tag == 10 {
                resultLabel.text = "0."
            }
            else{
                resultLabel.text = "\(tag)"
            }
        }
        else if let text = resultLabel.text{
            if tag == 10 {
                var str = ""
                str = "."
                if resultLabel.text?.contains(str) == false {
                    resultLabel.text = "\(text)\(str)"
                }
            }
            else{
                resultLabel.text = "\(text)\(tag)"
            }
        }
    }
    @objc func negPressed(_ sender: UIButton) {
        if let text = resultLabel.text, let value = Double(text){
            let result = -value
            resultLabel.text = "\(result)"
        }
    }
    
    @objc func modPressed(_ sender: UIButton) {
        if let text = resultLabel.text, let value = Double(text){
            let result = value / 100
            resultLabel.text = "\(result)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        if nextNum == 2 {
            nextNum = 1
        }
        let tag = sender.tag
        if tag != 5{
            if let text = resultLabel.text, let value = Double(text){
                firstNum = value
            }
        }
        
        if tag == 1{
            currentOperation = .divide
            nextNum = 1
        } else if tag == 2{
            currentOperation = .multiply
            nextNum = 1
        } else if tag == 3{
            currentOperation = .substract
            nextNum = 1
        } else if tag == 4{
            currentOperation = .add
            nextNum = 1
        } else if tag == 5{
            nextNum = 2
            if let operation =  currentOperation {
                var lastNum = 0.0
                if let text = resultLabel.text, let value = Double(text){
                    lastNum = value
                }
                
                switch operation {
                case .divide:
                    let result = firstNum / lastNum
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                   let result = firstNum * lastNum
                   resultLabel.text = "\(result)"
                   break
                case .substract:
                    let result = firstNum - lastNum
                    resultLabel.text = "\(result)"
                    break
                case .add:
                    let result = firstNum + lastNum
                    resultLabel.text = "\(result)"
                    break
                }
            }
            if resultLabel.text == "-0.0" {
                resultLabel.text = "0.0"
            }
        }
        
    }
}

//TODO: 连续运算，应该要转换成字符串处理。数位显示
