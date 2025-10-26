//
//  ScannerView.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//
import SwiftUI
import AVFoundation

struct ScannerView: View {
    @StateObject private var viewModel = ScannerViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.cameraAccessGranted {
                CameraViewControllerRepresentable(session: viewModel.session)
                    .ignoresSafeArea()
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 4)
                    .frame(width: 300, height: 260)
                    .shadow(radius: 4)
            } else {
                VStack(spacing: 20) {
                    Image(systemName: "camera.slash")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    Text("Разрешение на камеру не предоставлено")
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Открыть настройки") {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .onAppear {
            viewModel.startSession()
        }
        .onDisappear {
            viewModel.stopSession()
        }
        .toolbar {
            Button {
                viewModel.toggleTorch()
            } label: {
                Image(systemName: viewModel.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
            }
        }
        .onChange(of: viewModel.scannedCode) { newCode in
            if let code = newCode {
                print("Найден штрихкод: \(code)")
            }
        }
    }
}
