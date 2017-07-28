//
//  MemeDetailViewController.swift
//  MemeMe2.0
//
//  Created by Taylor Masterson on 7/28/17.
//  Copyright © 2017 Taylor Masterson. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memeImage!
    }


}
