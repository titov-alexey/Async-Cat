//
//  NetworkService.swift
//  Async Cat
//
//  Created by R2D2 on 21.08.2021.
//

import Foundation

protocol NetworkService {
    func startObserve(observer: @escaping ((String) -> Void))
    func connect()
    func disconnect()
}

class LocalNetworkService: NetworkService {
    
    let session = URLSession(configuration: .default)
    var socket: URLSessionWebSocketTask?
    
    func connect() {
        socket = session.webSocketTask(with: URL(string: "ws://192.168.1.7/ws")!)
        socket?.resume()
    }
    
    func startObserve(observer: @escaping ((String) -> Void)) {
        socket?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    observer(text)
                default:
                    print("получил не текст")
                }
                self?.startObserve(observer: observer)
            case .failure(let error):
                print(error)
                self?.disconnect()
            }
        }
    }
    
    func disconnect() {
        socket?.cancel(with: .goingAway, reason: nil)
    }
    
}



