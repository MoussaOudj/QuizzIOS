//
//  CustomCategorieView.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 01/01/2021.
//

import Foundation
import UIKit

public class CustomCategorieView:UIView{
    
    var image:UIImageView!
    var text:String?
    
    public override func draw(_ rect: CGRect) {
       
        guard let imageView = self.image else {return}
        
      
        
        let labelText = UILabel()
        labelText.text = self.text
        labelText.textAlignment = .center
        labelText.textColor = .white
        labelText.backgroundColor = .init(red: 33/255, green: 144/255, blue: 241/255, alpha: 0.6)
        labelText.frame = CGRect(x: 0, y: rect.height/2, width: rect.width, height: rect.height/4)
        
        imageView.frame = rect
        self.addSubview(imageView)
        #if os(tvOS)
        imageView.overlayContentView.addSubview(labelText)
        imageView.adjustsImageWhenAncestorFocused = true
        #else
        imageView.addSubview(labelText)
        #endif
    }
}
