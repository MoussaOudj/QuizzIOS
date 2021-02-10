//
//  CategoriesCollectionViewCell.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 27/12/2020.
//

import UIKit


class CategoriesCollectionViewCell: UICollectionViewCell {

    
    //@IBOutlet weak var categorieLabel: UILabel!
    @IBOutlet weak var customCategorieView: CustomCategorieView!
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        print("focused")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(imageJson:String,customText:String){
        customCategorieView.image = imageJson
        customCategorieView.text =  customText
    }


}
