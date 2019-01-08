//
//  ConversationCell.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {

    @IBOutlet weak var viewForLetter: UIView!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewForLetter.makeCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
