//
//  BandGeneratorVC.swift
//  MetalBeast
//
//  Created by Leon on 12/5/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import UIKit
import AVFoundation

class BandGeneratorVC: UIViewController {

    @IBOutlet weak var band_label: UILabel!
    
    @IBOutlet weak var year_label: UILabel!
    
    @IBOutlet weak var origin_label: UILabel!
    
    @IBOutlet weak var generate_btn: UIButton!
    var audioplayer1 = AVAudioPlayer()
    var audioplayer2 = AVAudioPlayer()
    var audioplayer3 = AVAudioPlayer()
    
    var bands = [Band]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        band_label.text=NSLocalizedString("str_band", comment: "")
        year_label.text=NSLocalizedString("str_year", comment: "")
        band_label.textColor=col2
        origin_label.text=NSLocalizedString("str_origin", comment: "")
        generate_btn.setTitle(NSLocalizedString("str_generate", comment: ""), for: .normal)
        generate_btn.setTitleColor(col1, for: .normal)
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in
            if UserDefaults.standard.bool(forKey: welcome) {
                let alert = UIAlertController(title: NSLocalizedString("str_welcometitle", comment: ""),
                                              message: NSLocalizedString("str_welcomemess", comment: ""),
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
        }
        guard let songsURL = Bundle.main.url(forResource: "bands", withExtension: "json") else { return }
                   guard let contents = try? Data(contentsOf: songsURL) else { return }
                   let library = JSON(contents).arrayValue
        for song in library {
            //print(Int(song["formed"].int16Value))
            bands.append(Band(band: song["band"].stringValue, formed: Int(song["formed"].int16Value), origin: song["origin"].stringValue))
        }
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
         let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
                   
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        upSwipe.direction = .up
        downSwipe.direction = .down

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
         view.addGestureRecognizer(upSwipe)
         view.addGestureRecognizer(downSwipe)
        // Do any additional setup after loading the view.
        
        let sound1 = Bundle.main.path(forResource: "People=shit", ofType: "m4a")
        let sound2 = Bundle.main.path(forResource: "Psychosocial", ofType: "m4a")
        let sound3 = Bundle.main.path(forResource: "Left behind", ofType: "m4a")
        
        do{
            audioplayer1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
            
        }
        catch{
            print(error)
        }
        
        
        do{
            audioplayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
            
        }
        catch{
            print(error)
        }
        
        
        do{
                   audioplayer3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound3!))
                   
               }
               catch{
                   print(error)
               }
               
        
    }
    
    
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (sender.direction == .left) {
                print("Swipe Left")
            audioplayer1.play()
        }
            
        if (sender.direction == .right) {
            print("Swipe Right")
            audioplayer2.play()
            
        }
        
        if (sender.direction == .up) {
            print("Swipe up")
            audioplayer3.play()
        }
        if (sender.direction == .down) {
            print("Swipe down")
            
            audioplayer1.stop()
            audioplayer2.stop()
            audioplayer3.stop()
            
        }
    }
    @IBAction func ontap_generate(_ sender: Any) {
        var band=bands[Int.random(in: 0..<bands.count)]
        
        band_label.text=band.band
        year_label.text=band.formed.description
        origin_label.text=band.origin
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
