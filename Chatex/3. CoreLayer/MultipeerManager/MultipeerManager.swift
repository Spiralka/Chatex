//
//  MultipeerManager.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import MultipeerConnectivity


class MultipeerManager: NSObject, ICommunicationService {
    
        var advertiser: MCNearbyServiceAdvertiser!
        var browser: MCNearbyServiceBrowser!
        var session: MCSession!
        var mypeerID: MCPeerID!
        let serviceType = "tinkoff-chat"
        var delegate: CommunicationServiceDelegate? = nil
        var online: Bool = false
    
    func send(_ message: Message, to peer: Peer) {
      
    }
    
    func partyTime() {
        mypeerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: mypeerID,  securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        startAdvertising()
        startBrowsing()
    }
    
    
    var dictValue: [String : String] = ["Lol":"Kek"]
    func startAdvertising() {
        advertiser = MCNearbyServiceAdvertiser(peer: mypeerID,
                                               discoveryInfo: dictValue,
                                               serviceType: serviceType)
        advertiser.delegate = self
        advertiser.startAdvertisingPeer()
    }
    
    func startBrowsing() {
        browser = MCNearbyServiceBrowser(peer: mypeerID, serviceType: serviceType)
        browser.delegate = self
        browser.startBrowsingForPeers()
        
    }
    
}

extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
       print("I LOST PEER \(peerID)")
    }
    
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("I FOUND \(info, peerID)")
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
        browser.stopBrowsingForPeers()
    }

    
}

extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        invitationHandler(true, self.session)
        advertiser.stopAdvertisingPeer()
    }
}

func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
    print(#function + "didNotStartAdvertisingPeer")
}

extension MultipeerManager: MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
}
