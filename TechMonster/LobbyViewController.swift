//
//  LobbyViewController.swift
//  TechMonster
//
//  Created by 吉川莉央 on 2018/04/12.
//  Copyright © 2018年 RioYoshikawa. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    var maxStamina: Float = 100
    var stamina: Float = 100
    var player: Player = Player()
    var staminaTimer: Timer!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!
    
    @IBAction func startButtle() {
        if stamina >= 20 {
            stamina = stamina - 20
            staminaBar.progress = stamina / maxStamina
            performSegue(withIdentifier: "startBattle", sender: nil)
        }else{
            let alert = UIAlertController(title: "スタミナ不足", message: "スタミナが20以上必要です",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startBattle" {
            let battleVC = segue.destination as! BattleViewController
            player.currentHP = player.maxHP
            battleVC.player = player
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //ステータスバーを縦に拡大
        staminaBar.transform = CGAffineTransform(scaleX: 1.0, y:4.0)
        //プレイヤーのデータをセット
        nameLabel.text = player.name
        levelLabel.text = String(format: "Lv. %d", player.level)
        //スタミナを起動時に最大
        stamina = maxStamina
        staminaBar.progress = stamina / maxStamina
        staminaTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:
            #selector(self.cureStamina), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.playBGM(fileName: "lobby")
    }
    
    @objc func cureStamina(){
        if stamina < maxStamina {
            stamina = min(stamina + 1, maxStamina)
            staminaBar.progress = stamina / maxStamina
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.stopBGM()
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
