//
//  CommunicationService.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class CommunicationService: CommunicationServiceDelegate {
    
    func communicationService(_ communicationService: ICommunicationService, didFoundPeer peer: Peer) {
        
    }
    
    func communicationService(_ communicationService: ICommunicationService, didLostPeer peer: Peer) {
        print("I did lost peer \(peer)")

        
    }
    
    func communicationService(_ communicationService: ICommunicationService, didNotStartBrowsingForPeers error: Error) {
        
    }
    
    func communicationService(_ communicationService: ICommunicationService, didReceiveInviteFromPeer peer: Peer, invintationClosure: (Bool) -> Void) {
        
    }
    
    func communicationService(_ communicationService: ICommunicationService, didNotStartAdvertisingForPeers error: Error) {
        
    }
    
    func communicationService(_ communicationService: ICommunicationService, didReceiveMessage message: Message, from peer: Peer) {
        
    }
    
   
    
    
   
    
}
