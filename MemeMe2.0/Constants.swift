//
//  Constants.swift
//  MemeMe2.0
//
//  Created by Taylor Masterson on 8/22/17.
//  Copyright © 2017 Taylor Masterson. All rights reserved.
//

import UIKit


class Constants {
    static let MemeTableViewCellTextAttributes: [String : Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    static let MemeEditorVCTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]
}
