//
//  ViewController.swift
//  MetalBeast
//
//  Created by Leon on 12/5/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadJson(filename: "bands")
        guard let songsURL = Bundle.main.url(forResource: "bands", withExtension: "json") else { return }
                   guard let contents = try? Data(contentsOf: songsURL) else { return }
                   let library = JSON(contents).arrayValue
        for song in library {
            print(song["origin"].stringValue)
        }

        // Do any additional setup after loading the view.
    }

   
    
    
    
    func loadJson(filename fileName: String) -> [Band]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.bands
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
}

