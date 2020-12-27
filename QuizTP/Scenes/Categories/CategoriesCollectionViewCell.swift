//
//  CategoriesCollectionViewCell.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 27/12/2020.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categorieLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //0, 80, 157
        self.backgroundColor = .init(red: 0, green: 80/255, blue: 157/255, alpha: 1)
        //255, 213, 0
        self.categorieLabel.textColor = .init(red: 1, green: 213/255, blue: 0, alpha: 1)
    }

}
