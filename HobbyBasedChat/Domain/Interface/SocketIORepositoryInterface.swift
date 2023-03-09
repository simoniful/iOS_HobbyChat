//
//  SocketIORepositoryInterface.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2023/03/10.
//

import Foundation
import SocketIO

protocol SocketIORepositoryInterface: AnyObject {
  func listenConnect(completion: @escaping ([Any], SocketAckEmitter) -> Void)
  
  func listenDisconnect(completion: @escaping ([Any], SocketAckEmitter) -> Void)
  
  func receivedChat(completion: @escaping (Chat, SocketAckEmitter) -> Void)
  
  func connectSocket()
  
  func disconnectSocket()
}
