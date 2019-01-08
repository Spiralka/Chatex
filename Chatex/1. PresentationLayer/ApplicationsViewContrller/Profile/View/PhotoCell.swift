//
//  PhotoCell.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 25/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageOfCell: MagicImage!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageOfCell?.cancelTask()
        imageOfCell?.image = UIImage(named: "placeholder")
    }
}
