//
//  NetworkConnectivity.swift
//  Forecast
//
//  Created by Steve Hechio on 26/08/2023.
//

import Foundation
import Network

class NetworkConnectivity {
    
    static let shared = NetworkConnectivity()
    
    private let monitor = NWPathMonitor()
    private var isConnected = true
    private var isMonitoring = false
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        if isMonitoring {
            return
        }
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        
        let queue = DispatchQueue(label: "NetworkMonitorQueue")
        monitor.start(queue: queue)
        isMonitoring = true
    }
    
    func stopMonitoring() {
        monitor.cancel()
        isMonitoring = false
    }
    
    func isReachable() -> Bool {
        return isConnected
    }
}
