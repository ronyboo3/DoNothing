//
//  RowViewCell.swift
//  DoNothing
//
//  Created by 棚瀬 隆太 on 2017/03/02.
//  Copyright © 2017年 棚瀬 隆太. All rights reserved.
//

import UIKit

enum RowViewCellRows {
    case lastTapCount
    case totalTapCount
    case fastestTapTime
    case latestTapTime
    
    func toRow() -> Int {
        return self.hashValue
    }
    
    func toTitle() -> String {
        switch self {
        case .lastTapCount:
            return "前回プレイ時のボタンタップ回数"
        case .totalTapCount:
            return "累計ボタンタップ回数"
        case .fastestTapTime:
            return "ボタンがアクティブになってから最も速かったタップ時間"
        case .latestTapTime:
            return "ボタンがアクティブになってから最も遅かったタップ時間"
        }
    }
    
    static let count = 4
}

class RowViewCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.7
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }

}
