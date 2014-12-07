//
//  DetailViewController.swift
//  LearningCoreImageDemo
//
//  Created by Guanshan Liu on 23/11/2014.
//  Copyright (c) 2014 guanshanliu. All rights reserved.
//

import UIKit
import CoreImage

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

    typealias Filter = CIImage -> CIImage

    let filters = [singleFilter, filterChain, customFilter]

    @IBAction func processImage(sender: UIButton) {
        sender.enabled = false

        let inputImage = CIImage(CGImage: imageView.image?.CGImage)
        let outputImage = filters[rowIndex](inputImage)
        imageView.image = UIImage(CIImage: outputImage)
    }

}

func singleFilter(image: CIImage) -> CIImage {
    let filter = CIFilter(name: "CISepiaTone")
    filter.setValue(image, forKey: kCIInputImageKey)
    filter.setValue(1.0, forKey: kCIInputIntensityKey)
    return filter.outputImage
}

func filterChain(image: CIImage) -> CIImage {
    let filters = image.autoAdjustmentFilters() as [CIFilter]
    let output = filters.reduce(image, combine: { (input, filter) -> CIImage in
        filter.setValue(input, forKey: kCIInputImageKey)
        return filter.outputImage
    })
    return output
}

func customFilter(image: CIImage) -> CIImage {
    let filter = MotionBlurFilter()
    filter.setValue(image, forKey: kCIInputImageKey)
    return filter.outputImage
}