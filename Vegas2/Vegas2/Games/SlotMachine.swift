//
//  SlotMachine.swift
//  Vegas2
//
//  Created by hackeru on 07/01/2018.
//  Copyright © 2018 dan. All rights reserved.
//

import UIKit
import AVFoundation

class SlotMachine: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var Chip_Count: UILabel!
    @IBOutlet weak var Btn: UIButton!
    @IBOutlet weak var PickerView: UIPickerView!
    @IBOutlet weak var ResultLabel: UILabel!
    
    var fruitArray = [String]()
    var component1 = [Int]()
    var component2 = [Int]()
    var component3 = [Int]()
    
    func randomNumber(num: Int) -> Int{
        return Int(arc4random_uniform(UInt32(num)))
    }
    
    /*override*/
    func preferredStatusBarStyle() -> UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    var Money = 0
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        Money = DataManager.sharedManager.score
       // self.Chip_Count.text = String(self.Money)
        
     //   Chip_Count.layer.cornerRadius = 8.0
    //    Chip_Count.layer.masksToBounds = true
        Btn.layer.cornerRadius = 8.0
        
        fruitArray = ["🍉", "🍇", "🍓", "🍒", "🍑", "🍊", "🍋", "🍐", "🍌", "🍎"]
        
        // for(var i = 0; i < 100; i++)
        let numbers = 1...100
        for _ in numbers
        {
            
            component1.append(randomNumber(num: 10))
            component2.append(randomNumber(num: 10))
            component3.append(randomNumber(num: 10))
        }
        
        ResultLabel.text = ""
        
        PickerView.delegate = self
        PickerView.dataSource = self
    }
    
    @IBAction func SpinBtn(_ sender: UIButton) {
        
        //display random pic
        PickerView.selectRow((randomNumber(num: 10)), inComponent: 0, animated: true)
        PickerView.selectRow((randomNumber(num: 10)), inComponent: 1, animated: true)
        PickerView.selectRow((randomNumber(num: 10)), inComponent: 2, animated: true)
        
        if(component1[PickerView.selectedRow(inComponent: 0)] == component2[PickerView.selectedRow(inComponent: 1)] && component2[PickerView.selectedRow(inComponent: 1)] == component3[PickerView.selectedRow(inComponent: 2)]){
            
            //win
            self.ResultLabel.text = "Winner!!"
            self.ResultLabel.isHidden = false
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
                self.ResultLabel.isHidden = true
            }
            DataManager.sharedManager.score += 50
        }else{
            //play again
            if DataManager.sharedManager.score <= 0{
                sender.isEnabled = false
                self.ResultLabel.text = "Out of Money"
                self.ResultLabel.isHidden = false
                
            }else{
                DataManager.sharedManager.score -= 10
            }
      //      Chip_Count.text = String(Money)
        }
        
        //animate
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            //play button increase
            
        }, completion: { finished in
            
            UIView.animate(withDuration: 1.3, delay: 0.0, options: .curveEaseOut, animations: {
                //play buttone decrease
                
            }, completion: nil)
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    //UIPickerView DataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //nimber of rows
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 95.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        //display random emoji - switch case
        switch component {
        case 0:
            pickerLabel.text = fruitArray[component1[row]]
            break
            
        case 1:
            pickerLabel.text = fruitArray[component2[row]]
            break
            
        case 2:
            pickerLabel.text = fruitArray[component3[row]]
            break
            
        default:
            pickerLabel.text = fruitArray[component1[row]]
        }
        
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
  
    
    @IBAction func Back_Btn(_ sender: UIButton) {
        
        
    }
 
    func animateLabel(){
        
        /*
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            self.ResultLabel.tag += 1
            if self.ResultLabel.tag >= 3{
                self.ResultLabel.tag = 0
                timer.invalidate()
                return
            }
            
            UIView.animate(withDuration: 1.0, animations: {
                self.ResultLabel.alpha = 1.0
            }, completion: {
                (Completed : Bool) -> Void in
                UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                    self.ResultLabel.alpha = 0
                })
            })
        }
        */
    }
    
 

    
    
}
