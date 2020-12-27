//
//  CategoriesViewController.swift
//  QuizTP
//
//  Created by OUDJAMA Moussa (Canal Plus) on 27/12/2020.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    let categoriesTable:[String] = ["cinema", "culture", "informatique", "loisirs", "sciences", "television", "arts", "musique"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.categoriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categorieCell")
        self.categoriesCollectionView.delegate = self
        self.categoriesCollectionView.dataSource = self
    }
}

extension CategoriesViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let createQuizz = QuizViewController.newInstance(selectedTheme: categoriesTable[indexPath.row])
        self.navigationController?.pushViewController(createQuizz, animated: true)
    }
    
}

extension CategoriesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesTable.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorieCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.categorieLabel.text = categoriesTable[indexPath.row]
        return cell
        
    }


}
