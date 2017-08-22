//
//  MemeTableViewCell.swift
//  MemeMe2.0
//
//  Created by Taylor Masterson on 7/28/17.
//  Copyright © 2017 Taylor Masterson. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCellWith(meme:Meme) {
        originalImage?.image =  meme.originalImage!
        topLabel?.attributedText = NSAttributedString(string: meme.topText!, attributes: Constants.MemeTableViewCellTextAttributes)
        bottomLabel?.attributedText = NSAttributedString(string: meme.bottomText!, attributes: Constants.MemeTableViewCellTextAttributes)
        memeText?.text = "\(meme.topText!)...\(meme.bottomText!)"
    }

}
