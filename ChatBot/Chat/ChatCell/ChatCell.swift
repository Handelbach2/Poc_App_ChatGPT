//
//  ChatCell.swift
//  ChatBot
//
//  Created by Fabian Labra on 06/04/23.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatContentView: UIView!
    @IBOutlet weak var chatLabel: UILabel!
    
    // constrains outlets
    
    @IBOutlet weak var leftConstr: NSLayoutConstraint!
    @IBOutlet weak var rightConst: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }
    
    func configView() {
        chatContentView.layer.cornerRadius = 12
        chatContentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
