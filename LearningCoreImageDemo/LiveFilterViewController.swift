//
//  LiveFilterViewController.swift
//  LearningCoreImageDemo
//
//  Created by Guanshan Liu on 30/11/2014.
//  Copyright (c) 2014 guanshanliu. All rights reserved.
//

import UIKit
import CoreImage
import GLKit
import AVFoundation

private var SessionQueueIdentifier: Int8 = 0

class LiveFilterViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var glView: GLKView!

    var coreImageContext: CIContext!
    var glContext: EAGLContext!

    let sessionQueue = dispatch_queue_create(&SessionQueueIdentifier, DISPATCH_QUEUE_SERIAL)
    let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()

        glContext = EAGLContext(API: .OpenGLES3)
        glView.context = glContext
        glView.contentScaleFactor = 1
        coreImageContext = CIContext(EAGLContext: glContext)

        session.beginConfiguration()

        if session.canSetSessionPreset(AVCaptureSessionPreset1280x720) {
            session.sessionPreset = AVCaptureSessionPreset1280x720
        }

        let devices = AVCaptureDevice.devices() as [AVCaptureDevice]
        var videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        for device in devices {
            if device.position == .Front && device.hasMediaType(AVMediaTypeVideo) {
                videoDevice = device
                break
            }
        }
        let videoInput = AVCaptureDeviceInput(device: videoDevice, error: NSErrorPointer.null())
        session.addInput(videoInput)

        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA]
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        session.addOutput(videoOutput)

        session.commitConfiguration()
        session.startRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        var image = CIImage(CVPixelBuffer: pixelBuffer)
        image = image.imageByApplyingTransform(CGAffineTransformMakeRotation(CGFloat(-M_PI_2)))
        image = image.imageByApplyingTransform(CGAffineTransformMakeTranslation(0, 1280))
        image = sepiaTone(image)
        var bounds = glView.bounds
        bounds.size.width = bounds.width * UIScreen.mainScreen().scale
        bounds.size.height = bounds.height * UIScreen.mainScreen().scale
        coreImageContext.drawImage(image, inRect: bounds, fromRect: bounds)
        glContext.presentRenderbuffer(Int(GL_RENDERBUFFER))
    }

    func sepiaTone(image: CIImage) -> CIImage {
        let filter = CIFilter(name: "CISepiaTone")
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(float: 1.0), forKey: kCIInputIntensityKey)
        return filter.outputImage
    }

}
