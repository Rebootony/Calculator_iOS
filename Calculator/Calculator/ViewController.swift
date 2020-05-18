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
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = .white
        zeroButton.setTitle("0", for: .normal)
        holder.addSubview(zeroButton)
        
        for x in 0..<3{
            let otherButton = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-2*buttonSize, width: buttonSize, height: buttonSize))
            otherButton.setTitleColor(.black, for: .normal)
            otherButton.backgroundColor = .white
            otherButton.setTitle("\(x+1)", for: .normal)
            holder.addSubview(otherButton)
        }
        for x in 0..<3{
            let otherButton2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-3*buttonSize, width: buttonSize, height: buttonSize))
            otherButton2.setTitleColor(.black, for: .normal)
            otherButton2.backgroundColor = .white
            otherButton2.setTitle("\(x+4)", for: .normal)
            holder.addSubview(otherButton2)
        }
        for x in 0..<3{
            let otherButton3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-4*buttonSize, width: buttonSize, height: buttonSize))
            otherButton3.setTitleColor(.black, for: .normal)
            otherButton3.backgroundColor = .white
            otherButton3.setTitle("\(x+7)", for: .normal)
            holder.addSubview(otherButton3)
        }
    }

}

