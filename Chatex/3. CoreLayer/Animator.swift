//
//  Animator.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 02/12/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import UIKit

class Animator {
    
    func startMeaninglessLove(emitter: CAEmitterLayer, tap: CGPoint)->(CAEmitterLayer) {
        
        let frameArea = CGRect(x: 0, y: 0, width: 80, height: 80)
        let emitterCell = CAEmitterCell()
        
        emitterCell.birthRate = 40
        emitterCell.lifetime = 2
        emitterCell.velocity = 100.0
        emitterCell.emissionRange = .pi
        emitterCell.contents = UIImage(named: "love")?.cgImage
        
        emitter.frame = frameArea
        emitter.emitterShape = CAEmitterLayerEmitterShape.sphere
        emitter.emitterPosition = tap
        emitter.emitterSize = frameArea.size
        emitter.emitterCells = [emitterCell]
        
        return emitter
        
    }
    
    func stopMeaninglessLove(emitter: CAEmitterLayer) {
        emitter.removeFromSuperlayer()
    }
}
