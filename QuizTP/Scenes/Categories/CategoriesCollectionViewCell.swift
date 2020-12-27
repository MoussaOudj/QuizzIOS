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
        self.backgroundColor = .init(red: 241/255, green: 240/255, blue: 204/255, alpha: 1)
        self.categorieLabel.textColor = .init(red: 167/255, green: 29/255, blue: 49/255, alpha: 1)
    }

}
