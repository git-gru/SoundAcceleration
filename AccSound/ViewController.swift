//
//  ViewController.swift
//  AccSound
//
//  Created by Jackie Chan on 7/21/17.
//  Copyright © 2017 Jackie Chan. All rights reserved.
//

import UIKit
import os.log

var soundState: Bool?
var volumeSize: Int?

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sound = UserDefaults.standard.value(forKey: "soundState"), let volume = UserDefaults.standard.value(forKey: "volumeSize") {
            soundState = sound as? Bool;
            volumeSize = volume as? Int;
        } else {
            // Set default settins.
            soundState = true;
            volumeSize = 50;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func unwindToMainScene(sender: UIStoryboardSegue) {
        saveSettings()
    }

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    */
    
    // MARK: - Private Methods
    
    private func saveSettings() {
        
        UserDefaults.standard.set(soundState, forKey: "soundState")
        UserDefaults.standard.set(volumeSize, forKey: "volumeSize")

    }
}

