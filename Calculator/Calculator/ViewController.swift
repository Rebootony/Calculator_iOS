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
    
    var clearButton = UIButton()
    var firstNum = 0.0
    var resultNum = 0.0
    var nextNum = 0
    var currentOperation: Operations?
    var countOp = 0
    var consecOp = 0 // check: last one is op?
    enum Operations {
        case divide, multiply, substract, add, equal
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name:"Arial", size: 60)
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
        let buttonSize = view.frame.size.width / 4.5
        
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-1.1*buttonSize, width: buttonSize*2.14, height: buttonSize))
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.backgroundColor = .darkGray
        zeroButton.tag = 1
        zeroButton.setTitle("0", for: .normal)
        zeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        zeroButton.layer.cornerRadius = buttonSize / 2
        zeroButton.clipsToBounds = true
        zeroButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        zeroButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 95)
        
        let dotButton = UIButton(frame: CGRect(x: buttonSize*(8 / 3.55), y: holder.frame.size.height-1.1*buttonSize, width: buttonSize, height: buttonSize))
        dotButton.setTitleColor(.white, for: .normal)
        dotButton.backgroundColor = .darkGray
        dotButton.tag = 11
        dotButton.setTitle(".", for: .normal)
        dotButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(dotButton)
        dotButton.layer.cornerRadius = buttonSize / 2
        dotButton.clipsToBounds = true
        dotButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        for x in 0..<3{
            let otherButton = UIButton(frame: CGRect(x: buttonSize * (CGFloat(x) * 4 / 3.55), y: holder.frame.size.height-2.2*buttonSize, width: buttonSize, height: buttonSize))
            otherButton.setTitleColor(.white, for: .normal)
            otherButton.backgroundColor = .darkGray
            otherButton.tag = x+2
            otherButton.setTitle("\(x+1)", for: .normal)
            otherButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(otherButton)

            otherButton.layer.cornerRadius = buttonSize / 2
            otherButton.clipsToBounds = true
            otherButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        }
        for x in 0..<3{
            let otherButton2 = UIButton(frame: CGRect(x: buttonSize * (CGFloat(x) * 4 / 3.55), y: holder.frame.size.height-3.3*buttonSize, width: buttonSize, height: buttonSize))
            otherButton2.setTitleColor(.white, for: .normal)
            otherButton2.backgroundColor = .darkGray
            otherButton2.tag = x+5
            otherButton2.setTitle("\(x+4)", for: .normal)
            otherButton2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(otherButton2)
            otherButton2.layer.cornerRadius = buttonSize / 2
            otherButton2.clipsToBounds = true
            otherButton2.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        }
        for x in 0..<3{
            let otherButton3 = UIButton(frame: CGRect(x: buttonSize * (CGFloat(x) * 4 / 3.55), y: holder.frame.size.height-4.4*buttonSize, width: buttonSize, height: buttonSize))
            otherButton3.setTitleColor(.white, for: .normal)
            otherButton3.backgroundColor = .darkGray
            otherButton3.tag = x+8
            otherButton3.setTitle("\(x+7)", for: .normal)
            otherButton3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(otherButton3)
            otherButton3.layer.cornerRadius = buttonSize / 2
            otherButton3.clipsToBounds = true
            otherButton3.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        }
        
        clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-5.5*buttonSize, width: buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .lightGray
        clearButton.setTitle("AC", for: .normal)//初始化是AC
        holder.addSubview(clearButton)
        clearButton.layer.cornerRadius = buttonSize / 2
        clearButton.clipsToBounds = true
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        
        let negButton = UIButton(frame: CGRect(x: buttonSize * (4 / 3.55), y: holder.frame.size.height-5.5*buttonSize, width: buttonSize, height: buttonSize))
        negButton.setTitleColor(.black, for: .normal)
        negButton.backgroundColor = .lightGray
        negButton.setTitle("+/-", for: .normal)
        holder.addSubview(negButton)
        negButton.addTarget(self, action: #selector(negPressed(_:)), for: .touchUpInside)
        negButton.layer.cornerRadius = buttonSize / 2
        negButton.clipsToBounds = true
        negButton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        
        let modButton = UIButton(frame: CGRect(x: buttonSize * (8 / 3.55), y: holder.frame.size.height-5.5*buttonSize, width: buttonSize, height: buttonSize))
        modButton.setTitleColor(.black, for: .normal)
        modButton.backgroundColor = .lightGray
        modButton.setTitle("%", for: .normal)
        holder.addSubview(modButton)
        modButton.addTarget(self, action: #selector(modPressed(_:)), for: .touchUpInside)
        modButton.layer.cornerRadius = buttonSize / 2
        modButton.clipsToBounds = true
        modButton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        
        let operation = ["÷","×","-","+","="]
        for x in 0..<5{
            let opButton = UIButton(frame: CGRect(x: buttonSize * 3.4, y: holder.frame.size.height-buttonSize * 1.1 * CGFloat(x+1), width: buttonSize, height: buttonSize))
            opButton.setTitleColor(.white, for: .normal)
            opButton.backgroundColor = .systemOrange
            opButton.setTitle(operation[4-x], for: .normal)
            opButton.tag = 5-x
            holder.addSubview(opButton)
            opButton.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            opButton.layer.cornerRadius = buttonSize / 2
            opButton.clipsToBounds = true
            opButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
            if x == 2{
                opButton.titleLabel?.font = UIFont.systemFont(ofSize: 42)
            }
        }
        resultLabel.frame = CGRect(x: 0, y: holder.frame.size.height-buttonSize * 7.1, width: view.frame.size.width*0.95, height: 100)
        holder.addSubview(resultLabel)
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
    }
    
    @objc func clearResult() {
        resultLabel.text = "0"
        firstNum = 0.0
        nextNum = 0
        countOp = 0
        currentOperation = .equal
        consecOp = 0
        resultLabel.font = UIFont(name:"Arial", size: 60)
        clearButton.setTitle("AC", for: .normal)
    }
    
    @objc func numberPressed(_ sender: UIButton) {
        consecOp = 0
        let tag = sender.tag - 1
        if nextNum == 1 {
            resultLabel.text = "0"
            nextNum = 0
        }
        if nextNum == 2 {
            clearResult()
        }
        clearButton.setTitle("C", for: .normal)
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
            firstNum = result
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        if consecOp != 1{
            countOp += 1
            if nextNum == 2 {
                nextNum = 1
            }
            if countOp == 1{
                if let text = resultLabel.text, let value = Double(text){
                    firstNum = value
                }
            }
            
            if (tag == 5 || countOp > 1){
                if tag == 5 {
                    nextNum = 2
                    countOp = 0
                    consecOp = 0
                }
                if let operation =  currentOperation {
                    var lastNum = 0.0
                    if let text = resultLabel.text, let value = Double(text){
                        lastNum = value
                    }
                    
                    switch operation {
                    case .divide:
                        let result = firstNum / lastNum
                        resultLabel.text = "\(result)"
                        firstNum = result
                        break
                    case .multiply:
                        let result = firstNum * lastNum
                        resultLabel.text = "\(result)"
                        firstNum = result
                        break
                    case .substract:
                        let result = firstNum - lastNum
                        resultLabel.text = "\(result)"
                        firstNum = result
                        break
                    case .add:
                        let result = firstNum + lastNum
                        resultLabel.text = "\(result)"
                        firstNum = result
                        break
                    case .equal:
                        let result = lastNum
                        resultLabel.text = "\(result)"
                        firstNum = result
                        break
                    }
                }
                if resultLabel.text == "-0.0" {
                    resultLabel.text = "0.0"
                }
                if let text = resultLabel.text, let value2 = Double(text){
                    let number = NSNumber(value: value2)
                    let numberFormatter = NumberFormatter()
                    numberFormatter.maximumFractionDigits = 7 //设置小数点后最多7位
                    let format = numberFormatter.string(from: number)!
                    resultLabel.text = "\(format)"
                }
                scientiDisplay()
            }
        }
        if tag == 1{
            currentOperation = .divide
            nextNum = 1
            consecOp = 1
        } else if tag == 2{
            currentOperation = .multiply
            nextNum = 1
            consecOp = 1
        } else if tag == 3{
            currentOperation = .substract
            nextNum = 1
            consecOp = 1
        } else if tag == 4{
            currentOperation = .add
            nextNum = 1
            consecOp = 1
        }
    }
    
    private func scientiDisplay(){
        if let text = resultLabel.text, let value2 = Double(text){
            let str = "\(value2)"
            if str.count > 10 {
                let number = NSNumber(value: value2)
                let scientific = NumberFormatter.localizedString(from: number, number: .scientific)
                resultLabel.text = "\(scientific)"
                resultLabel.font = UIFont(name:"Arial", size: 40)
            }
        }
    }
    
    
}

//Fixme: 数位显示： 没有解决保留有效数字的问题，所以当科学计数法小数位过多时，没有控制好长度。
//Todo: 可以把操作符按键加动效
