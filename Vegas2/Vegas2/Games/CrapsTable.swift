//
//  CrapsTable.swift
//  Vegas2
//
//  Created by hackeru on 31/12/2017.
//  Copyright © 2017 dan. All rights reserved.
//

import UIKit
import AVFoundation

class CrapsTable: BaseViewController {
    
    @IBOutlet weak var Result_Label: UILabel!
    
    @IBOutlet weak var Throw_Btn: UIButton!
    
    @IBOutlet weak var rolling_dice: UIImageView!
    
    @IBOutlet weak var Left_Die: UIImageView!
    
    @IBOutlet weak var Right_Die: UIImageView!
    
    let dice = ["dice_1", "dice_2", "dice_3", "dice_4", "dice_5", "dice_6"]
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Throw_Btn.layer.cornerRadius = 8.0
        self.scoreLabel?.layer.cornerRadius = 8.0
        self.scoreLabel?.layer.masksToBounds = true

       rolling_dice.loadGif(name: "roll_dice2")
      
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "dice_sound", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
    }
    
    
    @IBAction func Throw_Dice(_ sender: UIButton) {
        if DataManager.sharedManager.score <= 0{
            sender.isEnabled = false
            self.Result_Label.text = "Out of Money"
            self.Result_Label.isHidden = false
        }else{
        self.Result_Label.isHidden = true
        sender.isEnabled = false
       
            audioPlayer.play()
        
        UIView.animate(withDuration: 1, animations: {
                self.Left_Die.isHidden = true
                self.Right_Die.isHidden = true
                self.rolling_dice.isHidden = false
                self.rolling_dice.frame.origin.y -= 400
            }, completion: { _ in sender.isEnabled = true})
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.rolling_dice.frame.origin.y = 450
            self.rolling_dice.isHidden = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.Left_Die.isHidden = false
            let leftIndex = Int(arc4random_uniform(6))
            self.Left_Die.image = UIImage(named: self.dice[leftIndex])
            
            self.Right_Die.isHidden = false
            let rightIndex = Int(arc4random_uniform(6))
            self.Right_Die.image = UIImage(named: self.dice[rightIndex])
            
            let leftValue = leftIndex + 1
            let rightValue = rightIndex + 1
            
         // let two_dice = (left, right)
            let two_dice = leftValue + rightValue
            
            switch two_dice{
            case 2:
                self.Result_Label.text = "Craps"
                self.Result_Label.isHidden = false
                DataManager.sharedManager.score -= 10
            case 3:
                self.Result_Label.text = "Craps"
                self.Result_Label.isHidden = false
                DataManager.sharedManager.score -= 10
            case 12:
                self.Result_Label.text = "Craps"
                self.Result_Label.isHidden = false
                DataManager.sharedManager.score -= 10
            case 7:
                self.Result_Label.text = "Winner"
                self.Result_Label.isHidden = false
                DataManager.sharedManager.score += 20
            case 11:
                self.Result_Label.text = "Winner"
                self.Result_Label.isHidden = false
                DataManager.sharedManager.score += 20
            case 4, 5, 6, 8, 9, 10:
                self.Result_Label.text = "Winner"
                self.Result_Label.isHidden = false
                DataManager.sharedManager.score += 10
            default:
                self.Result_Label.isHidden = true
            }
            
        }
}
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

