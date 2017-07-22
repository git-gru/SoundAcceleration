//
//  ViewController.swift
//  AccSound
//
//  Created by Jackie Chan on 7/21/17.
//  Copyright © 2017 Jackie Chan. All rights reserved.
//

import UIKit

var soundState: Bool?
var volumeSize: Int?

class ViewController: UIViewController {
    
    var sound: Bool?
    var volume: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        soundState = true;
        volumeSize = 50;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func unwindToMainScene(sender: UIStoryboardSegue) {
        
    }

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    */
}

