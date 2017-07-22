//
//  SettingViewController.swift
//  AccSound
//
//  Created by Jackie Chan on 7/22/17.
//  Copyright © 2017 Jackie Chan. All rights reserved.
//

import UIKit
import os.log

class SettingViewController: UIViewController {
    
    // MARK: - Properties
    
    var sound: Bool?
    var volume: Int?
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var saveSettingButton: UIBarButtonItem!
    @IBOutlet weak var volumeSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sound = soundState
        volume = volumeSize
        
        soundSwitch.setOn(sound!, animated: true)
        volumeSlider.setValue(Float(volume!), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func soundStateChanged(_ sender: UISwitch) {
        if sender.isOn {
            sound = true;
        } else {
            sound = false;
        }
        print(String(describing: soundState))
    }

    @IBAction func volumeChanged(_ sender: UISlider) {
        volume = Int(sender.value)
        print(String(describing: volume))
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveSettingButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        soundState = sound
        volumeSize = volume
    }
    
    // Private methods
}
