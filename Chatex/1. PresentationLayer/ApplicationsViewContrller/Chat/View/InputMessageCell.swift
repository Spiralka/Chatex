//
//  InputMessageCell.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import UIKit

class InputMessageCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewForMessage(blurEffect)
    
        // Initialization code
    }
    
    func setupViewForMessage(_ view: UIView) {
        view.layer.cornerRadius = 14
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner ]
        view.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
