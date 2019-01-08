//
//  PhotoModel.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 25/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import UIKit


struct PhotoData: Codable {
    let  hits: [InsideItems]
}

struct InsideItems: Codable {
    let  webformatURL: String?
    
}


