//
//  DrawLayer.swift
//  XMPP_Project
//
//  Created by 曾亮敏 on 16/6/30.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit

class DrawLayer: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
