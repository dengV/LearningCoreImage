//
//  DetailViewController.swift
//  LearningCoreImageDemo
//
//  Created by Guanshan Liu on 23/11/2014.
//  Copyright (c) 2014 guanshanliu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var rowIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.image = UIImage(named: "Image")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func processImage(sender: UIButton) {
        sender.enabled = false

    }

}

