//
//  ViewController.swift
//  Clock
//
//  Created by Life is Tech! on 2014/12/31.
//  Copyright (c) 2014年 Life is Tech!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var hour2Label: UILabel!
    @IBOutlet var hour1Label: UILabel!
    @IBOutlet var minute2Label: UILabel!
    @IBOutlet var minute1Label: UILabel!
    @IBOutlet var second2Label: UILabel!
    @IBOutlet var second1Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(time),
                                         userInfo: nil,
                                         repeats: true)
        timer.fire()
    }
    
    @objc func time(){
        
        let date: Date = Date()
        let calendar: Calendar = Calendar(identifier: .gregorian)
        let components: DateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        let hour:Int = components.hour!
        let minute:Int = components.minute!
        let second:Int = components.second!

        hour2Label.text = String(hour/10)
        hour1Label.text = String(hour%10)
        minute2Label.text = String(minute/10)
        minute1Label.text = String(minute%10)
        second2Label.text = String(second/10)
        second1Label.text = String(second%10)
    }
}
