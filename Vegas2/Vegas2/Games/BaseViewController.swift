//
//  BaseViewController.swift
//  Vegas2
//
//  Created by hackeru on 17/01/2018.
//  Copyright © 2018 dan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var scoreLabel : UILabel?
    @IBOutlet weak var btn_coins: UIButton!
    
    @IBAction func add_coin(_ sender: UIButton) {
        DataManager.sharedManager.score += 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scoreLabel?.layer.cornerRadius = 8.0
        self.scoreLabel?.layer.masksToBounds = true
        self.btn_coins?.layer.cornerRadius = 8.0
        
        
        refreshScoreLabel()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshScoreLabel), name: .scoreUpatedNotification, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func refreshScoreLabel(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        scoreLabel?.text = formatter.string(from: DataManager.sharedManager.score as NSNumber)
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
