//
//  TVC.swift
//  MetalBeast
//
//  Created by Leon on 12/6/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import UIKit
import CoreData

class Customcell: UITableViewCell {

    
    @IBOutlet weak var song_label: UILabel!
    
    @IBOutlet weak var artist_label: UILabel!
    
    @IBOutlet weak var genre_label: UILabel!
    
    @IBOutlet weak var date_label: UILabel!
    
    @IBOutlet weak var mood_image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class TVC: UITableViewController {
    
    
    var entry: [NSManagedObject] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
readData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entry.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

         let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)as! Customcell
               let item = entry[indexPath.row]
                      cell.song_label?.text = item.value(forKeyPath: "song") as? String
               cell.artist_label?.text = item.value(forKeyPath: "artist") as? String
               cell.genre_label?.text = item.value(forKeyPath: "genre") as? String
        cell.date_label?.text = item.value(forKeyPath: "date") as? String
        switch(item.value(forKeyPath: "mood")as? Int)
        {
         case 0: cell.mood_image.image=UIImage(named: "0")
        case 1: cell.mood_image.image=UIImage(named: "1")
        case 2: cell.mood_image.image=UIImage(named: "2")
        case 3: cell.mood_image.image=UIImage(named: "3")
        case 4: cell.mood_image.image=UIImage(named: "4")
        case 5: cell.mood_image.image=UIImage(named: "5")
            
        
        default:cell.mood_image.image=UIImage(named: "1")
        }


             

        return cell
    }
    
    func readData() {
           let context = AppDelegate.cdContext
           let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
           do {
              entry = try context.fetch(fetchRequest)
           } catch let error as NSError {
               print("Could not fetch requested item. \(error), \(error.userInfo)")
           }
           tableView.reloadData()
       }
    
   @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
       readData()
       tableView.reloadData()
    NotificationCenter.default.post(name: Notifications.experience, object: nil)
    UserDefaults.standard.set((entry.count)*5, forKey: exp)
   }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               if let item = entry[indexPath.row] as? Item, let song = item.song {
                   deletionAlert(song: song) { _ in
                       self.deleteItem(item: item)
                   }
               }
           }
        NotificationCenter.default.post(name: Notifications.decrease, object: nil)
           UserDefaults.standard.set((entry.count)*5, forKey: exp)
       }
    
    func deletionAlert(song: String, completion: @escaping (UIAlertAction) -> Void) {
        
        let alertMsg = NSLocalizedString("alertmsg", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("warning", comment: ""), message: alertMsg, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    func deleteItem(item: Item) {
           let context = AppDelegate.cdContext
           if let _ = entry.firstIndex(of: item)  {
               context.delete(item)
               do {
                   try context.save()
               } catch let error as NSError {
                   print("Could not delete the item. \(error), \(error.userInfo)")
               }
           }
           readData()
       }
}
