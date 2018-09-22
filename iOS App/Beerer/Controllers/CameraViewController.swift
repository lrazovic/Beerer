//
//  CameraViewController.swift
//  Beerer
//
//  Created by Leonardo Razovic on 01/03/2018.
//  Copyright © 2018 Leonardo Razovic. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBAction func scatta(_ sender: UIButton) {
        
    }
    @IBOutlet weak var scattaButton: UIButton!
    @IBOutlet weak var sfondoView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarController?.tabBar.isHidden = true
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            previewView.layer.addSublayer(videoPreviewLayer!)
            previewView.addSubview(closeButton)
            previewView.addSubview(sfondoView)
            previewView.addSubview(scattaButton)
            captureSession?.startRunning()
        } catch {
            print(error)
        }
    }

}
