//
//  ViewController.swift
//  Gyro Slider
//
//  Created by Ben Scott on 15/03/2015.
//  Copyright (c) 2015 Schmurgon Pty Ltd. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let motionManager = CMMotionManager()
    var updateTimer: NSTimer!
    
    @IBOutlet weak var rollSlider: UISlider!
    
    override func viewWillAppear(animated: Bool) {
        rollSlider.minimumValue = -1.0
        rollSlider.maximumValue = 1.0
        
        if motionManager.deviceMotionAvailable {
            motionManager.startDeviceMotionUpdates()
            startTimer()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if motionManager.deviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.05,  target: self, selector: "updateSliderUsingRoll", userInfo: nil, repeats: true)
    }
    
    func updateSliderUsingRoll() {
        let motion = motionManager.deviceMotion
        if motion != nil {
            let roll = motion.attitude.roll
            
            dispatch_async(dispatch_get_main_queue(), {
                var sliderValue = self.rollSlider.value
                
                if ( roll < 0 ) {
                    sliderValue = sliderValue - 0.05;
                } else {
                    sliderValue = sliderValue + 0.05;
                }
                self.rollSlider.setValue( sliderValue, animated: true )
            })
        }
    }
}

