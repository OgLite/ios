//
//  Page_Scanner.swift
//  Oglite
//
//  Created by Jianzhi.wang on 2020/2/3.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit
import AVFoundation
import UIKit
import JzIos_Framework
class Page_Scanner: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var tit: UILabel!
    var scanback:((_ string:String)->Void?)? = nil
    @IBOutlet weak var Qrplace: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tit.text="Please_scan_the_QR_Code_on_the_catalog_or_poster".Mt()
                       captureSession = AVCaptureSession()
                        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
                        let videoInput: AVCaptureDeviceInput
                        
                        do {
                            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
                        } catch {
                            return
                        }
                        
                        if (captureSession.canAddInput(videoInput)) {
                            captureSession.addInput(videoInput)
                        } else {
                            failed()
                            return
                        }
                        
                        let metadataOutput = AVCaptureMetadataOutput()
                        
                        if (captureSession.canAddOutput(metadataOutput)) {
                            captureSession.addOutput(metadataOutput)
                            
                            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                            metadataOutput.metadataObjectTypes = [.dataMatrix]
                        } else {
                            failed()
                            return
                        }
                        
                        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                        previewLayer.frame = Qrplace.layer.bounds
                        previewLayer.videoGravity = .resizeAspectFill
                        Qrplace.layer.addSublayer(previewLayer)
                        
                        captureSession.startRunning()
    }
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           if (captureSession?.isRunning == false) {
               captureSession.startRunning()
           }
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           
           if (captureSession?.isRunning == true) {
               captureSession.stopRunning()
           }
}
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
                  captureSession.stopRunning()
                      
                      if let metadataObject = metadataObjects.first {
                          guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                          guard let stringValue = readableObject.stringValue else { return }
                          AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                        JzActivity.getControlInstance.goBack()
                        scanback!(stringValue)
                        print(stringValue)
            }
    }
    
    override var prefersStatusBarHidden: Bool {
             return true
         }
         override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
             return .portrait
         }
}
