//
//  ImageLoaderTest.swift
//  doOrGoToPyaterochkaTests
//
//  Created by  Евгений on 09/12/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import XCTest
import UIKit
@testable import doOrGoToPyaterochka

class ImageLoaderTest: XCTestCase {
    
    var imageLoader: ImageLoaderMock!
    var networkManager: NetworkManagerMock!
    
    override func setUp() {
        imageLoader = ImageLoaderMock()
        networkManager = NetworkManagerMock()
    }

    override func tearDown() {
        super.tearDown()
        imageLoader = nil
        networkManager = nil
    }

    func testImageLoaderCallsNetworkMaanger() {
        
        //GIVEN
        
        guard let url = URL(string: "https://www.google.com") else { return }

        //WHEN
        
        imageLoader.requestImage(url: url)
        
        //THEN
        
        XCTAssert(networkManager.isSendCalled)

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
