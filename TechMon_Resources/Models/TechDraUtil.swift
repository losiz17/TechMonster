//
//  TechDraUtility.swift
//  TechDra
//
//  Created by Master on 2015/03/23.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit
import AVFoundation

class TechDraUtil {
    
    static var bgmPlayer: AVAudioPlayer?
    static var sePlayer: AVAudioPlayer?
    
    //MARK: Animations
    static func animateDamage(_ view: UIView) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.02
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }
    
    static func animateVanish(_ view: UIView, duration: Double = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            view.alpha = 0.0
        }, completion: nil)
    }

    //MARK: Sound Effects
    static func playSE(fileName: String) {
        if let soundFilePath = Bundle.main.path(forResource: fileName, ofType: "mp3") {
            if let audiPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundFilePath), fileTypeHint: nil) {
                audiPlayer.numberOfLoops = 1
                audiPlayer.prepareToPlay()
                sePlayer = audiPlayer
            }
        }
        sePlayer?.play()
    }
    
    static func playBGM(fileName: String) {
        if let soundFilePath = Bundle.main.path(forResource: fileName, ofType: "mp3") {
            if let audiPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundFilePath), fileTypeHint: nil) {
                audiPlayer.numberOfLoops = -1
                audiPlayer.prepareToPlay()
                bgmPlayer = audiPlayer
            }
        }
        bgmPlayer?.play()
    }
    
    static func stopBGM() {
        bgmPlayer?.stop()
    }
}
