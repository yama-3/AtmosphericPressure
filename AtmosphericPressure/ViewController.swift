//
//  ViewController.swift
//  AtmosphericPressure
//
//  Created by yama3 on 2017/08/22.
//  Copyright © 2017年 yama3. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let altimeter = CMAltimeter()
    
    @IBOutlet weak var pressureLabel: UILabel!

    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBAction func doReset(_ sender: Any) {
        altimeter.stopRelativeAltitudeUpdates()
        startUpdate()
    }

    func startUpdate() {
        self.pressureLabel.text = "気圧:---- hPa"
        self.altitudeLabel.text = "高さ:-,-- m"
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: {
                data, error in
                if error == nil {
                    let pressure:Double = Double(data!.pressure)
                    let altitude:Double = Double(data!.relativeAltitude)
                    self.pressureLabel.text = String(format: "気圧:%.1f hPa", pressure * 10)
                    self.altitudeLabel.text = String(format: "高さ:%.2f m", altitude)
                }
            })
        }
        else {
            print("not use altimeter")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

