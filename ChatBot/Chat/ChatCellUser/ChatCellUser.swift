//
//  ChatCellUser.swift
//  ChatBot
//
//  Created by Fabian Labra on 06/04/23.
//

import UIKit

class ChatCellUser: UITableViewCell {

    @IBOutlet weak var viewContentChat: UIView!
    @IBOutlet weak var labelUser: UILabel!
    
    
    @IBOutlet weak var leftConst: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }
    
    func configView() {
        viewContentChat.layer.cornerRadius = 12
        viewContentChat.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
