//
//  MemeCollectionViewController.swift
//  MemeMe2.0
//
//  Created by Rafif Kalantan on 18/06/2020.
//  Copyright © 2020 Rafif Kalantan. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    
   @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell

        let meme = Meme.getMemeStorage().memes[indexPath.item]

        cell.updateCell(meme)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {

        let meme = memes[(indexPath as NSIndexPath).row]

        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
            detailController.meme = meme

        navigationController!.pushViewController(detailController, animated: true)
    }
    
}
