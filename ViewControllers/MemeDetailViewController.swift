//
//  MemeDetailViewController.swift
//  MemeMe2.0
//
//  Created by Rafif Kalantan on 20/06/2020.
//  Copyright © 2020 Rafif Kalantan. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    var meme: Meme!


    //@IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var imageCell: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.imageCell!.image = meme.memedImage

    }
}
