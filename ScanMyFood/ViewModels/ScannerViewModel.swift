//
//  ScannerViewModel.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//
import AVFoundation
import SwiftUI
import Combine

final class ScannerViewModel: NSObject, ObservableObject {
    @Published var scannedCode: String?
    @Published var isTorchOn = false
    @Published var cameraAccessGranted = false
    
    let session = AVCaptureSession()
    
    override init() {
        super.init()
        checkCameraPermission()
    }

    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            cameraAccessGranted = true
            setupSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.cameraAccessGranted = granted
                    if granted {
                        self?.setupSession()
                    }
                }
            }
        case .denied, .restricted:
            cameraAccessGranted = false
        @unknown default:
            cameraAccessGranted = false
        }
    }
    
    private func setupSession() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device)
        else {
            print("Не удалось получить доступ к камере")
            return
        }

        if session.canAddInput(input) {
            session.addInput(input)
        } else {
            print("Не удалось добавить ВХОД в сессию")
            return
        }
        
        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            session.addOutput(output)
            output.metadataObjectTypes = [.qr, .ean13, .ean8, .code128]
        } else {
            print("Не удалось добавить ВЫХОД в сессию")
            return
        }
    }

    func startSession() {
        guard cameraAccessGranted else { return }   
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            if !session.isRunning {
                session.startRunning()
                print("\(session.isRunning)")
            }
        }
    }

    func stopSession() {
        if session.isRunning { session.stopRunning() }
    }

    func toggleTorch() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            device.torchMode = isTorchOn ? .off : .on
            isTorchOn.toggle()
            device.unlockForConfiguration()
        } catch { print(error) }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScannerViewModel:  AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let code = object.stringValue {
            scannedCode = code
            stopSession()
        }
    }
}
