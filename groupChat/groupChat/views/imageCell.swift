//
//  imageCell.swift
//  groupChat
//
//  Created by Apple on 30/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class imageCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    func configureCell(image: profileImage) {
        profileImage.image = UIImage(named: image.imageName)
    }
}
