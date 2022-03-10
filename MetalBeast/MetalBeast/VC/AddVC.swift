//
//  AddVC.swift
//  MetalBeast
//
//  Created by Leon on 12/6/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import UIKit
import CoreData

class AddVC: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate  {
    
    
    
    @IBOutlet weak var genre_picker: UIPickerView!
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     
         return GenreType.allCases.count
     
     
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
          return GenreType(rawValue: row)?.title()
    
    }
    
    
    @IBOutlet weak var cancel_btn: UIButton!
    @IBOutlet weak var add_btn: UIButton!
    @IBOutlet weak var song_label: UILabel!
    
    @IBOutlet weak var artist_label: UILabel!
    
    @IBOutlet weak var mood_label: UILabel!
    
    @IBOutlet weak var song_textfield: UITextField!
    
    
    @IBOutlet weak var artist_textfield: UITextField!
    
    @IBOutlet weak var mood_textfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genre_picker.delegate = self
           genre_picker.dataSource = self
        song_label.text=NSLocalizedString("str_song", comment: "")
        artist_label.text=NSLocalizedString("str_artist", comment: "")
        mood_label.text=NSLocalizedString("str_mood", comment: "")
        add_btn.setTitle(NSLocalizedString("str_add", comment: ""), for: .normal)
        cancel_btn.setTitle(NSLocalizedString("str_cancel", comment: ""), for: .normal)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func ontap_save(_ sender: Any) {
        let context = AppDelegate.cdContext
        if let song = song_textfield?.text{
                 
                if let entity = NSEntityDescription.entity(forEntityName: "Item", in: context) {
                    let item = NSManagedObject(entity: entity, insertInto: context)
                    item.setValue(song, forKeyPath: "song")
                    let artist=artist_textfield?.text
                    let mood=Int(mood_textfield?.text ?? "0")
                    item.setValue(GenreType(rawValue: genre_picker.selectedRow(inComponent: 0))?.title(),forKeyPath:"genre")
                     item.setValue(artist, forKeyPath: "artist")
                     item.setValue(mood, forKeyPath: "mood")
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()

                    dateFormatter.dateFormat = "dd/MM/yyyy"

                    let dateString = dateFormatter.string(from: currentDate)
                    item.setValue(dateString, forKeyPath: "date")
                    do {
                        try context.save()
                    } catch let error as NSError {
                        print("Could not save the item. \(error), \(error.userInfo)")
                    }
                }
            }

            presentingViewController?.dismiss(animated: true)
    }
    @IBAction func ontap_cancel(_ sender: Any) {
        
               let alert = UIAlertController(title: NSLocalizedString("canceltitle", comment: ""), message:  NSLocalizedString("cancelmsg", comment: ""), preferredStyle: .alert)

               
               let yesAction=UIAlertAction(title: NSLocalizedString("actionyes", comment: ""), style: .default) {[unowned self] action in
                   self.presentingViewController?.dismiss(animated: true)
               }
               
               alert.addAction(UIAlertAction(title: NSLocalizedString("actionno", comment: ""), style: .cancel, handler: nil))
               alert.addAction(yesAction)
               

               self.present(alert, animated: true)
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
