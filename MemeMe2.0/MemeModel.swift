//
//  MemeModel.swift
//  MemeMe2.0
//
//  Created by Rafif Kalantan on 18/06/2020.
//  Copyright © 2020 Rafif Kalantan. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: NSString!
    var bottomText: NSString!
    var image: UIImage!
    var memedImage: UIImage!
    
    //Get a count of all Memes
    static func count() -> Int {
        return getMemeStorage().memes.count
    }

    //Locate the Meme storage location
    static func getMemeStorage() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
}
