//
//  TMHomeViewController.swift
//  ThinMe
//
//  Created by ZhangMing on 12/12/14.
//  Copyright (c) 2014 ZhangMing. All rights reserved.
//

import UIKit

class TMHomeViewController: UIViewController {
    
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var beaconCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func handleMapAction(sender: AnyObject) {
        println("handleMapAction")
    }
    
    @IBAction func handleLocationAction(sender: AnyObject) {
        println("handleLocationAction")
    }
    
    @IBAction func handleTypeAction(sender: AnyObject) {
        println("handleTypeAction")
    }
    
    @IBAction func handleFootPrintAction(sender: AnyObject) {
        println("handleFootPrintAction")
    }
}
