//
//  MemeCollectionViewCell.swift
//  MemeMe2.0
//
//  Created by Rafif Kalantan on 20/06/2020.
//  Copyright © 2020 Rafif Kalantan. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    //MARK: Outlets

    //@IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var memedImage: UIImageView!

    //MARK: Custom Cell's Functions

    func updateCell(_ meme: Meme) {

        //update cell's view
        memedImage.image = meme.memedImage
    }
}
