//
//  AppsController.swift
//  Apps
//
//  Created by Xiomara on 2/9/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import UIKit
import AFNetworking

class AppsController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var category: UIButton!
    @IBOutlet weak var categoriesView: CategoriesView!

    var apps = [App]()
    var filteredApps = [App]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        APIClient.shared.getTopApps(success: { topApps in
            self.apps = topApps
            self.collectionView.reloadData()
            
        }, failure: { error in
            print(error)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Selector Methods
    @IBAction func onCategoryButton(_ sender: Any) {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            let scaleTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.category.transform = scaleTransform
            self.category.frame.origin.x = 14.0
            
            self.categoriesView.isHidden = false
            self.categoriesView.frame.origin.x = 0
        })
    }
}

// MARK: - Collection View Methods
extension AppsController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredApps.count > 0 ? filteredApps.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appCell", for: indexPath) as! AppCell
        let app = filteredApps[indexPath.row]
        
        cell.nameLabel.text = app.name
        if let imageURL = app.imageURL {
            cell.appImageVIew.setImageWith(URL(string:imageURL)!)   
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cell = collectionView.cellForItem(at: indexPath) as! AppCell
        
        UIView.transition(with: cell,
                          duration: 0.5,
                          options:  [.transitionFlipFromRight, .showHideTransitionViews],
                          animations: nil,
                          completion: { (finished: Bool) -> () in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navController = storyboard.instantiateViewController(withIdentifier: "AppDetailsNC")
            let controller = navController.childViewControllers[0] as! AppDetailsController
                controller.appShown = self.filteredApps[indexPath.row]
                            
            self.present(navController, animated: true, completion: nil)
        })
    }
}

// MARK: - Categories View Methods
extension AppsController: CategoriesViewProtocol {
    internal func didCategoryChanged(category: String) {
        self.category.setTitle(category, for: .normal)
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            let scaleTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.category.frame.origin.x = (UIScreen.main.bounds.width / 2) - (self.category.frame.width / 2)
            self.category.transform = scaleTransform
            
            self.categoriesView.isHidden = true
            self.categoriesView.frame.origin.x = UIScreen.main.bounds.width
        })
        
        let filtered = apps.filter { $0.category == category }
        filteredApps = filtered
        
        collectionView.reloadData()
    }
}

