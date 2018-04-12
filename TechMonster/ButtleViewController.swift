//
//  ButtleViewController.swift
//  TechMonster
//
//  Created by 吉川莉央 on 2018/04/12.
//  Copyright © 2018年 RioYoshikawa. All rights reserved.
//

import UIKit

class ButtleViewController: UIViewController {
    var enemyAttackTimer: Timer!
    var enemy: Enemy!
    var player: Player!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var attackButton: UIButton!
    
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var playerImageView: UIImageView!
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var playerHPBar: UIProgressView!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var playerNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enemyHPBar.transform = CGAffineTransform(scaleX: 1.0, y:4.0)
        playerHPBar.transform = CGAffineTransform(scaleX: 1.0, y:4.0)
        
        playerNameLabel.text = player.name
        playerImageView.image = player.image
        playerHPBar.progress = player.currentHP / player.maxHP
        
        startBattle()

        // Do any additional setup after loading the view.
    }
    
    func startBattle() {
        TechDraUtil.playBGM(fileName: "BGM_battle001")
        
        enemy = Enemy()
        //敵のデータセット
        enemyNameLabel.text = enemy.name
        enemyImageView.image = enemy.image
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        //攻撃ボタン表示
        attackButton.isHidden = false
        //敵の自動攻撃
        enemyAttackTimer = Timer.scheduledTimer(timeInterval: enemy.attackInterval, target: self,
                                                selector: #selector(self.enemyAttack), userInfo: nil, repeats: true)
    }
    
    @IBAction func playerAttack() {
        TechDraUtil.animateDamage(enemyImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
        //HP更新
        enemy.currentHP = enemy.currentHP - player.attackPower
        enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
        //敵の敗北
        if enemy.currentHP < 0 {
            TechDraUtil.animateVanish(enemyImageView)
            finishBattle(winPlayer: true)
        }
    }
    
    func finishBattle(winPlayer: Bool) {
        enemyAttackTimer.invalidate()
        TechDraUtil.stopBGM()
        //攻撃ボタンおす
        attackButton.isHidden = true
        //敵の自動攻撃とめる
        enemyAttackTimer.invalidate()
        //アラートを表示
        let finishedMessage: String
        if winPlayer == true {
            TechDraUtil.playSE(fileName: "SE_fanface")
            finishedMessage = "プレイヤーの勝利！！"
        }else{
            TechDraUtil.playSE(fileName: "SE_gameover")
            finishedMessage = "プレイヤーの敗北..."
        }
        let alert = UIAlertController(title: "バトル終了！",message: finishedMessage, preferredStyle:UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            //OKをおすとモーダルを消して、Lobbyへ戻る
            self.dismiss(animated:  true, completion: nil)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func enemyAttack(){
        TechDraUtil.animateDamage(playerImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
        //HPの更新
        player.currentHP = player.currentHP - enemy.attackPower
        playerHPBar.setProgress(player.currentHP / player.maxHP, animated: true)
        //プレイヤーの敗北
        if player.currentHP < 0 {
            TechDraUtil.animateVanish(playerImageView)
            finishBattle(winPlayer: false)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
