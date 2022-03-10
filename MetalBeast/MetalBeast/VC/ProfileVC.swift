//
//  ProfileVC.swift
//  MetalBeast
//
//  Created by Leon on 12/6/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import UIKit
import CoreData
class ProfileVC: UIViewController {
    
     
    
let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var message_switch: UISwitch!
    
    @IBOutlet weak var exp_label: UILabel!
    
    @IBOutlet weak var message_label: UILabel!
    @IBOutlet weak var EXP: UILabel!
    
    @IBOutlet weak var LEVEL: UILabel!
    
    @IBOutlet weak var level_label: UILabel!
    var expgain=false
    var expdecrease=false
    var level=0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "b.jpg")!)

        LEVEL.text=NSLocalizedString("str_level", comment: "")
        EXP.text=NSLocalizedString("str_experience", comment: "")
        NotificationCenter.default.addObserver(forName: Notifications.experience, object: nil, queue: nil) { _ in
            self.expgain=true
        }
        NotificationCenter.default.addObserver(forName: Notifications.decrease, object: nil, queue: nil) { _ in
            self.expdecrease=true
        }
        exp_label.text=defaults.integer(forKey: exp).description
        var point=defaults.integer(forKey: exp)
        if(point<20)
        {
            level=0
        }
        else if(point>=20&&point<40)
        {
            level=1
        }
        
        else if(point>=40&&point<80)
            
            {
                level=2
        }
        else if(point>=80&&point<160)
        {
            level=3
        }
        else if(point>=160&&point<300)
        {
            level=4
        }
        level_label.text=level.description
        
        switch(level)
        {
        case 0:profile_image.image=UIImage(named: "metallica")
        case 1:profile_image.image=UIImage(named: "Megadeth")
        case 2:    profile_image.image=UIImage(named: "Slayer")
        case 3: profile_image.image=UIImage(named: "behemoth")
        case 4:profile_image.image=UIImage(named: "Slipknot")
        default: profile_image.image=UIImage(named: "metallica")
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        switch(level)
        {
        case 0:profile_image.image=UIImage(named: "metallica")
        case 1:profile_image.image=UIImage(named: "Megadeth")
        case 2:    profile_image.image=UIImage(named: "Slayer")
        case 3: profile_image.image=UIImage(named: "behemoth")
        case 4:profile_image.image=UIImage(named: "Slipknot")
        default: profile_image.image=UIImage(named: "metallica")
        }
          message_switch.isOn = defaults.bool(forKey: welcome)
        exp_label.text=defaults.integer(forKey: exp).description
        if(expgain==true)
        {
            var newlevel=0
            var point=defaults.integer(forKey: exp)
                   if(point<20)
                   {
                       newlevel=0
                   }
                   else if(point>=20&&point<40)
                   {
                       newlevel=1
                   }
                   
                   else if(point>=40&&point<80)
                       
                       {
                           newlevel=2
                   }
                   else if(point>=80&&point<160)
                   {
                       newlevel=3
                   }
                   else if(point>=160&&point<300)
                   {
                       newlevel=4
                   }
            if(newlevel != self.level)
            {
                message_label.text=NSLocalizedString("str_upgrade", comment: "")
                message_label.center.x = view.center.x // Place it in the center x of the view.
                message_label.center.x -= view.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
                // animate it from the left to the right
                UIView.animate(withDuration: 2.5, delay: 0, options: [.curveEaseOut], animations: {
                    self.message_label.center.x += self.view.bounds.width
                      self.view.layoutIfNeeded()
                }, completion: nil)
                self.level=newlevel
                level_label.text=self.level.description
                let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

                UIView.transition(with: profile_image, duration: 3.0, options: transitionOptions, animations: {
                    self.profile_image.isHidden = true
                })
                switch(level)
                {
                case 0:profile_image.image=UIImage(named: "metallica")
                case 1:profile_image.image=UIImage(named: "Megadeth")
                case 2:    profile_image.image=UIImage(named: "Slayer")
                case 3: profile_image.image=UIImage(named: "behemoth")
                case 4:profile_image.image=UIImage(named: "Slipknot")
                default: profile_image.image=UIImage(named: "metallica")
                }
                
                UIView.transition(with: profile_image, duration: 3.0, options: transitionOptions, animations: {
                    self.profile_image.isHidden = false
                })
            }
            else{
                
            
            message_label.text=NSLocalizedString("str_exp", comment: "")
            message_label.center.x = view.center.x // Place it in the center x of the view.
            message_label.center.x -= view.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
            // animate it from the left to the right
            UIView.animate(withDuration: 2.5, delay: 0, options: [.curveEaseOut], animations: {
                self.message_label.center.x += self.view.bounds.width
                  self.view.layoutIfNeeded()
            }, completion: nil)
            
            expgain=false
            }
            
        }
        
        
       }
       
    
    @IBAction func onmessage_switch(_ sender: UISwitch) {
        
        defaults.set(sender.isOn, forKey: welcome)
    }
    
    

}
