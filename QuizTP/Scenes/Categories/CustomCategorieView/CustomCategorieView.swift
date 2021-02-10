//
//  CustomCategorieView.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 01/01/2021.
//

import Foundation
import UIKit
import Lottie

public class CustomCategorieView:UIView{
    
    var image:String?
    var text:String?
    
    
    public override func draw(_ rect: CGRect) {
       
       // guard let imageView = self.image else {return}
        
        let labelText = UILabel()
        labelText.text = self.text
        labelText.textAlignment = .center
        labelText.textColor = .white
        labelText.backgroundColor = .init(red: 33/255, green: 144/255, blue: 241/255, alpha: 0.6)
        labelText.frame = CGRect(x: 0, y: rect.maxY - rect.height/4, width: rect.width, height: rect.height/4)
        
        
        let animationView = AnimationView.init(name: image ?? "error")
        animationView.frame = rect
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.75
        animationView.addSubview(labelText)
        
        #if os(tvOS)
        let imageView = UIImageView(image: UIImage(named: "whiteBG"))
        imageView.frame = rect
        imageView.overlayContentView.addSubview(animationView)
        imageView.adjustsImageWhenAncestorFocused = true
        self.addSubview(imageView)
        #else
        self.addSubview(animationView)
        #endif
        
        animationView.play()
    }
}
