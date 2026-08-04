//
//  NetworkCheck.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 29/07/2026.
//

import Network
import Observation

@Observable
final class NetworkInfoService {
    var isConnected = false
    var connectionType = "Unknown"
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isConnected = path.status == .satisfied
                
                if path.usesInterfaceType(.wifi) {
                    self?.connectionType = "Wi-Fi"
                } else if path.usesInterfaceType(.wiredEthernet) {
                    self?.connectionType = "Ethernet"
                } else {
                    self?.connectionType = "Other"
                }
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func stop() {
        monitor.cancel()
    }
}
