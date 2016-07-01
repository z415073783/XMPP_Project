//
//  DrawTool.swift
//  XMPP_Project
//
//  Created by 曾亮敏 on 16/6/30.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit

//import SnapKit
class DrawTool: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var _target:DrawView!
    
    init(target:DrawView) {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.greenColor()
        setupButtons()
        _target = target
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //线条粗细,橡皮擦,颜色,退后,清除
    func setupButtons() -> Void
    {
        for i in 0...4
        {
            let button:UIButton = UIButton()
            self.addSubview(button)
            
            button.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self).offset(0)
                make.right.equalTo(self).offset(0)
                let beginPos:Float = Float(i)*40
                make.top.equalTo(self).offset(beginPos)
                make.height.equalTo(39.5)
            })
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.purpleColor().CGColor
            button.addTarget(self, action: #selector(touchButton), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = i
            button.setTitle(DRAWBUTTONTYPE[i] as? String, forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont(name: DRAWVIEW_FONTNAME_DEFAULT, size: 10)
            button.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
            
        }
        
        
        
        
    }
    func touchButton(sender:UIButton) -> Void
    {
        switch sender.tag {
            case DrawButtonType.line.rawValue:
                
                let lineView:DrawTool_Line = DrawTool_Line(colorArr: [UIColor.darkGrayColor(),UIColor.lightGrayColor(),UIColor.grayColor(),UIColor.redColor(),UIColor.greenColor(),UIColor.blueColor(),UIColor.cyanColor(),UIColor.yellowColor(),UIColor.magentaColor(),UIColor.orangeColor(),UIColor.purpleColor(),UIColor.brownColor()])
                self.addSubview(lineView)
                
                
            break
            case DrawButtonType.color.rawValue:
            
            break
            case DrawButtonType.rubber.rawValue:
            
            break
            case DrawButtonType.back.rawValue:
            
            break
            case DrawButtonType.clear.rawValue:
            
            break
            default: break
            
        }
        
        
        
        
        
    }
    
    
    

}
