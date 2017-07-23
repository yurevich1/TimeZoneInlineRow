//
//  ViewController.swift
//  TimeZoneInlineRow
//
//  Created by Vyacheslav Petrukhin on 07/23/2017.
//  Copyright (c) 2017 Vyacheslav Petrukhin. All rights reserved.
//

import UIKit
import Eureka
import TimeZoneInlineRow

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        form +++ TimeZoneInlineRow() {
            $0.title = "Pick Time Zone"
            $0.value = TimeZone.current
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

