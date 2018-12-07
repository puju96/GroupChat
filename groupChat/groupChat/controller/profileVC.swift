//
//  profileVC.swift
//  groupChat
//
//  Created by Apple on 30/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class profileVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    

    
}

extension profileVC : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.loadProfileImages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? imageCell else { return UICollectionViewCell()}
        let image = DataService.instance.loadProfileImages()[indexPath.row]
        cell.configureCell(image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DataService.instance.setProfileName(profileName: "img\(indexPath.row + 1)")
        dismiss(animated: true, completion: nil)
    }
    
}

