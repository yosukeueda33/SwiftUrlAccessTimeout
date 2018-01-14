//
//  ViewController.swift
//  SwiftUrlAccessTimeout
//
//  Created by 上田陽介 on 2018/01/14.
//  Copyright © 2018年 上田陽介. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDataDelegate {
    @IBOutlet weak var urlTextbox: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func accessButtonPushed(_ sender: Any) {
        messageLabel.text = "accessing..."
        
        let myConfig = URLSessionConfiguration.default
        myConfig.timeoutIntervalForRequest = 10 //the unit is second. 
        let mySession = Foundation.URLSession(configuration: myConfig, delegate:self, delegateQueue: nil)
        let myUrl:URL = URL(string: urlTextbox.text!)!
        debugPrint(myUrl)
        let myTask:URLSessionDataTask = mySession.dataTask(with: myUrl)
        
        myTask.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        DispatchQueue.main.async{
            self.messageLabel.text = "succeeded."
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError: Error?){
        DispatchQueue.main.async{
            if (didCompleteWithError != nil){
                self.messageLabel.text = "error."
            }
        }
    }
}

