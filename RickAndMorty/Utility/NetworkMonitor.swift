//
//  Reachability.swift
//  RickAndMorty
//
//  Created by aleksandre on 26.05.22.
//

import Foundation
import Network

final class NetworkMonitor
{
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    static let shared  = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let strongSelf = self else { return }
            strongSelf.isConnected = path.status == .satisfied
            strongSelf.getConnectionType(path)
            print(strongSelf.isConnected)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
}

