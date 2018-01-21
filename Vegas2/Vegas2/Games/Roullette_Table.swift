//
//  Roullette_Table.swift
//  Vegas2
//
//  Created by hackeru on 03/01/2018.
//  Copyright © 2018 dan. All rights reserved.
//

import UIKit
import AVFoundation

class Roullette_Table: BaseViewController {
    
    
    enum Mode{
        case none
        case black
        case red
    }
    
    var mode : Mode = .none{
        didSet{
            switch self.mode
            {
            case .black:
                self.Result_Label.isHidden = false
                self.Result_Label.backgroundColor = .black
                self.Result_Label.text = "Black"
                self.Result_Label.textColor = .white
                
            case .red:
                self.Result_Label.isHidden = false
                self.Result_Label.backgroundColor = .red
                self.Result_Label.text = "RED"
                self.Result_Label.textColor = .black
                
            case .none:
                self.Result_Label.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var winner_label: UILabel!
    
    @IBOutlet weak var Red_Radio: DLRadioButton!
    
    @IBOutlet weak var Black_Radio: DLRadioButton!
    
    @IBOutlet weak var roullette_disk: UIImageView!
    
    @IBOutlet weak var outer_disk: UIImageView!
    
    @IBOutlet weak var Result_Label: UILabel!
    
    @IBOutlet weak var Chip_Count: UILabel!
    
    @IBOutlet weak var spin_btn: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    
    var Money = 0
    
    override func viewDidLoad() {
        GZLogFunc()
        super.viewDidLoad()
        
        Money = DataManager.sharedManager.score
        
        self.mode = .none
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "roulette_sound", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        spin_btn.layer.cornerRadius = 8.0
        spin_btn.layer.masksToBounds = true
    }
    
    
    var isRedSelected : Bool{
        get{
            return self.Red_Radio.selected()?.isEqual(self.Red_Radio) == true
        }
    }
    
    var isBlackSelected : Bool{
        get{
            return self.Black_Radio.selected()?.isEqual(self.Black_Radio) == true
        }
    }
    
    func updateWinner(){
        
        func toggleWinningState(_ didWin : Bool){
            self.winner_label.isHidden = !didWin
            }
        
        switch mode
        {
        case .black:
            toggleWinningState(self.isBlackSelected)
        case .red:
            toggleWinningState(self.isRedSelected)
        case .none:
            toggleWinningState(false)
        }
    }
    
    @IBAction func spin(_ sender: UIButton) {
        if DataManager.sharedManager.score <= 0{
            sender.isEnabled = false
            self.winner_label.text = "Out of Money"
            self.winner_label.isHidden = false
        }else{
        self.spin_btn.isHidden = true
        
        
        self.mode = .none
        self.updateWinner()
        
        self.audioPlayer.play()
        
        GZLogFunc()
        
        UIView.animate(withDuration: 8, delay: 0, options: [UIViewAnimationOptions.curveEaseOut], animations: {
            GZLogFunc()
            for _ in 0..<10 {
                self.outer_disk.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 1))
                self.outer_disk.transform = CGAffineTransform(rotationAngle: 0)
            }
        }) { (completed) in
            GZLogFunc(completed)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8){
           
            self.spin_btn.isHidden = false
            
            let ball = Int(arc4random_uniform(10))
            
            switch ball{
            case 1,3,5,7,9:
                self.mode = .red
                if self.isRedSelected{
                    DataManager.sharedManager.score += 20
                }else if self.isBlackSelected{
                    DataManager.sharedManager.score -= 10
                }
            case 2,4,6,8,10:
                self.mode = .black
                if self.isBlackSelected{
                    DataManager.sharedManager.score += 20
                }else if self.isRedSelected{
                    DataManager.sharedManager.score -= 10
                }
            default:
                self.mode = .none
            }
            self.updateWinner()
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

