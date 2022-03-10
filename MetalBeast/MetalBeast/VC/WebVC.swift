//
//  WebVC.swift
//  MetalBeast
//
//  Created by Leon on 12/5/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import UIKit
import WebKit
class WebVC: UIViewController {

    @IBOutlet weak var URL_textfield: UITextField!
    
    
    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
 URL_textfield.text = "https://www.metal-archives.com/"
        loadRequest()
        
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
       }

       func loadRequest() {
           if let address = URL_textfield.text, let url = URL(string: address) {
               let request = URLRequest(url: url)
               webview.load(request)
           }
       }

    @IBAction func ontap_go(_ sender: Any) {
        loadRequest()
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
