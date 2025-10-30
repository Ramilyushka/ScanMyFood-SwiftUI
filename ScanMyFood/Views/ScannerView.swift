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
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                if viewModel.cameraAccessGranted {
                    
                    CameraViewControllerRepresentable(session: viewModel.session)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 40) {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 4)
                            .frame(width: 280, height: 240)
                            .shadow(radius: 4)
                        
                        Button {
                            viewModel.toggleTorch()
                        } label: {
                            Image(systemName: viewModel.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(viewModel.isTorchOn ? Color.yellow : Color.gray)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }
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
            .onChange(of: viewModel.scannedCode) { newCode in
                if let code = newCode {
                    path.append(code)
                }
            }
            .navigationDestination(for: String.self) { barcode in
                ProductDetailView(barcode: barcode)
            }
        }
        .navigationTitle("Сканировать")
    }
}
