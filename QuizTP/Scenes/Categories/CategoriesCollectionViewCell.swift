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
    
    let focusedColor = UIColor.init(red: 0, green: 80/255, blue: 157/255, alpha: 0.6)
    let cellColor = UIColor.init(red: 0, green: 80/255, blue: 157/255, alpha: 1)
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        print("focused")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(imageView:UIImageView,customText:String){
        customCategorieView.image = imageView
        customCategorieView.text =  customText
    }


}
