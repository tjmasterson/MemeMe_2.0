//
//  MemeListViewController.swift
//  MemeMe2.0
//
//  Created by Taylor Masterson on 7/25/17.
//  Copyright © 2017 Taylor Masterson. All rights reserved.
//

import UIKit

class MemeListViewControllerController: UIViewController {
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

