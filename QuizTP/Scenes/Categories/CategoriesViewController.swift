//
//  CategoriesViewController.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 27/12/2020.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    let categoriesTable:[(String,String)] = [("cinema","image-cine"), ("culture","image-culture"), ("informatique","image-informatique"), ("loisirs","image-loisirs"), ("sciences","image-sciences"), ("television","image-television"), ("arts","image-arts"), ("musique","image-musique")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //0, 63, 136
        self.categoriesCollectionView.backgroundColor = .init(red: 0, green: 63/255, blue: 136/255, alpha: 1)
        self.categoriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categorieCell")
        self.categoriesCollectionView.delegate = self
        self.categoriesCollectionView.dataSource = self
    }
}

extension CategoriesViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let createQuizz = QuizViewController.newInstance(selectedTheme: categoriesTable[indexPath.row].0)
        self.navigationController?.pushViewController(createQuizz, animated: true)
    }
    
}

extension CategoriesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesTable.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorieCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.configureCell(imageView: UIImageView(image: UIImage(named: categoriesTable[indexPath.row].1)), customText: categoriesTable[indexPath.row].0)
        return cell
        
    }
}

extension CategoriesViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        #if os(tvOS)
        return CGSize(width: self.categoriesCollectionView.bounds.width/4, height: self.categoriesCollectionView.bounds.height/4 )
        #endif
        
        return CGSize(width: self.categoriesCollectionView.bounds.width/2 - 10, height: self.categoriesCollectionView.bounds.height/4 - 10 )
    }
    
    #if os(tvOS)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    #endif
    
}
