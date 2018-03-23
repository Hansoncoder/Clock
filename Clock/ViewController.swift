//
//  ViewController.swift
//  Clock
//
//  Created by Hanson on 22/03/2018.
//  Copyright © 2018 Hanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weakLabel: UILabel!

    @IBOutlet weak var clockView: ClockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        clockView.delegate = self
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData(for: Date())
    }
    
}

extension ViewController: ClockViewDelegate {
    
    func clockView(_ clockView: ClockView, timeUpdate date: Date) {
        updateData(for: date)
    }
    
    internal func updateData(for date: Date) {
        hourLabel.text = "\(ClockTool.getDate(.hour, from: date))"
        minuteLabel.text = String(format: "%02d", ClockTool.getDate(.minute, from: date))
        
        monthLabel.text = "\(ClockTool.getDate(.month, from: date))"
        dayLabel.text = "\(ClockTool.getDate(.day, from: date))"
        weakLabel.text = ClockTool.getWeakDay(from: date)
    }
}

