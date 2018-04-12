//
//  Enemy.swift
//  techMon
//
//  Created by Yuki.F on 2015/10/27.
//  Copyright © 2015年 Yuki Futagami. All rights reserved.
//

import UIKit

class Enemy {
    
    var name: String = "ドラゴン"
    var image: UIImage! = UIImage(named: "monster.png")
    var maxHP: Float = 400
    var currentHP: Float = 400
    var attackPower: Float = 20
    var defencePoint: Float = 5
    var level: Int = 5
    var attackInterval: TimeInterval = 1.2
    // var currentMovePoint: Float = 0//行動するためのゲージの値
    // var maxMovePoint: Float = 35
    
    init(name:String, imageName:String) {
        self.name = name
        self.image = UIImage(named: imageName)
    }
    
    init() {
        
    }
}

