//
//  Protocols.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 02/12/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol ICommunicationService {
    // Делегат сервиса
    var delegate: CommunicationServiceDelegate? { get set }
    // Онлайн/Не онлайн
    var online: Bool { get set }
    // Отправляет сообщение участнику
    func send(_ message: Message, to peer: Peer)
}


protocol CommunicationServiceDelegate: class {
    // Browsing
    func communicationService(_ communicationService: ICommunicationService,
                              didFoundPeer peer: Peer)
    func communicationService(_ communicationService: ICommunicationService,
                              didLostPeer peer: Peer)
    func communicationService(_ communicationService: ICommunicationService,
                              didNotStartBrowsingForPeers error: Error)
    // Advertising
    func communicationService(_ communicationService: ICommunicationService,
                              didReceiveInviteFromPeer peer: Peer,
                              invintationClosure: (Bool) -> Void)
    func communicationService(_ communicationService: ICommunicationService,
                              didNotStartAdvertisingForPeers error: Error)
    // Messages
    func communicationService(_ communicationService: ICommunicationService,
                              didReceiveMessage message: Message,
                              from peer: Peer)
}
