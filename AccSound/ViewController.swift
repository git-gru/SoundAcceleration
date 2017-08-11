//
//  ViewController.swift
//  AccSound
//
//  Created by Jackie Chan on 7/21/17.
//  Copyright © 2017 Jackie Chan. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation
import os.log

var soundState: Bool?
var volumeSize: Double?
var oldLocation: CLLocation?
var oldSpeed: Double = 0

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - Properties
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var accelerationLabel: UILabel!

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timediffLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!

    var locationMgr: CLLocationManager!
    var player: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sound = UserDefaults.standard.value(forKey: "soundState"), let volume = UserDefaults.standard.value(forKey: "volumeSize") {
            soundState = sound as? Bool;
            volumeSize = volume as? Double;
        } else {
            // Set default settins.
            soundState = true;
            volumeSize = 0.5;
        }
        
        locationMgr = CLLocationManager()
        locationMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationMgr.distanceFilter = 1
        getLocation()
        
        do {
            let path = Bundle.main.path(forResource: "sound", ofType: "mp3")
            let url = URL(fileURLWithPath: path!)
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player.volume = 0
            player.prepareToPlay()
            player.play()
            player.numberOfLoops = -1
        } catch {
            print("Couldn't load file :(")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToMainScene(sender: UIStoryboardSegue) {
        if soundState == true {
            player.play()
        }
        else {
            player.stop()
        }
        
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
    
    private func getLocation() {
        let status  = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationMgr.requestWhenInUseAuthorization()
            return
        }
        
        if status == .denied || status == .restricted {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        locationMgr.delegate = self
        locationMgr.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations.last!
        guard currentLocation.verticalAccuracy > 10 else {

            if oldLocation != nil {
                let distance = currentLocation.distance(from: oldLocation!)
                distanceLabel.text = String(distance)
                let timediff = currentLocation.timestamp.timeIntervalSince((oldLocation?.timestamp)!)
                timediffLabel.text = String(timediff)
                let speed = distance/timediff
                speedLabel.text = String(speed)
                if oldSpeed >= 0 && speed >= 0 {
                    let accelerate = (speed - oldSpeed) / timediff
                    accelerationLabel.text = String(accelerate)
                    oldSpeed = speed
                    var volume: Float
                    volume = Float(accelerate * volumeSize!)
                    if volume < 0 {
                        volume = 0
                    }
                    volumeLabel.text = String(volume)
                    player.setVolume(volume, fadeDuration: 0.5)
                }
            }
            oldLocation = currentLocation
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

