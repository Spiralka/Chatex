//
//  NetworkManagerMock.swift
//  doOrGoToPyaterochkaTests
//
//  Created by  Евгений on 09/12/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
@testable import doOrGoToPyaterochka

final class NetworkManagerMock {
    
    var isSendCalled = false
    
    func getPhoto(url: URL) -> () {
        isSendCalled = true
    }
    
    
}
