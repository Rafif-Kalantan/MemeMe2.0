//
//  MemeTableViewController.swift
//  MemeMe2.0
//
//  Created by Rafif Kalantan on 18/06/2020.
//  Copyright © 2020 Rafif Kalantan. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
       }

       override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.memes.count
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath) as! MemeTableViewCell

                  let meme = Meme.getMemeStorage().memes[indexPath.row]

                  cell.updateCell(meme)

                  return cell
       }

       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let meme = memes[(indexPath as NSIndexPath).row]
        
           let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
               detailController.meme = meme

           self.navigationController!.pushViewController(detailController, animated: true)
       }
    
}
