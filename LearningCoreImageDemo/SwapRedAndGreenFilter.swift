//
//  SwapRedAndGreenFilter.swift
//  LearningCoreImageDemo
//
//  Created by Guanshan Liu on 07/12/2014.
//  Copyright (c) 2014 guanshanliu. All rights reserved.
//

import UIKit
import CoreImage

class SwapRedAndGreenFilter: CIFilter {

    private let kernelSource =  "kernel vec4 swapRenAndGreen ( __sample s ) { return s.grba; }"
    
    lazy var kernel:CIColorKernel = {
        return CIColorKernel(string: self.kernelSource)
        }()
    var inputImage: CIImage?

    override func setValue(value: AnyObject?, forKey key: String) {
        if key == kCIInputImageKey {
            if let image = value as? CIImage {
                inputImage = image
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }

    override func valueForKey(key: String) -> AnyObject? {
        if key == kCIInputImageKey {
            return inputImage
        } else {
            return super.valueForKey(key)
        }
    }

    override var outputImage: CIImage! {
        if let inputImage = inputImage {
            let dod = inputImage.extent()
            var args = [inputImage as AnyObject]
            return kernel.applyWithExtent(dod, arguments: args)
        }
        return nil
    }

}
