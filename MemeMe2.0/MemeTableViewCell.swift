//
//  MemeTableViewCells.swift
//  MemeMe2.0
//
//  Created by Rafif Kalantan on 20/06/2020.
//  Copyright © 2020 Rafif Kalantan. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    //MARK: Properties

   // @IBOutlet weak var memedImage: UIImageView!
   // @IBOutlet weak var topText: UILabel!
   // @IBOutlet weak var bottomText: UILabel!
    
    @IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!

    //MARK: Custom Cell's Functions

    func updateCell(_ meme: Meme) {

        //update cell's view
        memedImage.image = meme.memedImage
        topText.text = meme.topText as String?
        bottomText.text = meme.bottomText as String?
    }
}
