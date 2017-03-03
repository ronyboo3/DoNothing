//
//  SectionViewCell.swift
//  DoNothing
//
//  Created by 棚瀬 隆太 on 2017/03/02.
//  Copyright © 2017年 棚瀬 隆太. All rights reserved.
//

import UIKit

class SectionViewCell: UITableViewCell {

    @IBOutlet weak var sectionBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionBackgroundView.layer.shadowOffset = CGSize(width: 1.6, height: 1.6)
        sectionBackgroundView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
