//
//  NetworkTask.swift
//  ScanMyFood-UIKit
//
//  Created by Ramilia on 25/10/25.
//
import Foundation

protocol NetworkTask {
    func cancel()
}

struct DefaultNetworkTask: NetworkTask {
    let dataTask: URLSessionDataTask

    func cancel() {
        dataTask.cancel()
    }
}
