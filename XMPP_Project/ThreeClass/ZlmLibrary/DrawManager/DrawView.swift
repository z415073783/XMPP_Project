//
//  DrawView.swift
//  XMPP_Project
//
//  Created by 曾亮敏 on 16/6/30.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit
enum DrawButtonType:NSInteger {
    case line,color,rubber,back,clear
}
let DRAWBUTTONTYPE:NSArray = ["线条","颜色","橡皮擦","退后","重置"]
let DRAWVIEW_FONTNAME_DEFAULT = "Helvetica"


class DrawView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let board:DrawLayer = DrawLayer()
        self.addSubview(board)
        board.sd_layout().leftEqualToView(self).rightEqualToView(self).topEqualToView(self).bottomEqualToView(self)
        
        let tool:DrawTool = DrawTool.init(target: self)
        self.addSubview(tool)
        tool.sd_layout().leftSpaceToView(self,10).widthIs(40).topSpaceToView(self,10).heightIs(200)
//        tool.setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeState(type:DrawButtonType,state:NSInteger) -> Void
    {
        
        
        
    }
    
    
    
    

}
