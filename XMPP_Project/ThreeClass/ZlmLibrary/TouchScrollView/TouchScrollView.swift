//
//  TouchScrollView.swift
//  XMPP_Project
//
//  Created by zlm on 16/7/5.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit

class TouchScrollView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    //MARK: 定义属性
    /// 容器层
    var _container:UIView = UIView()
    var container:UIView{
        set{
            _container = newValue
        }
        get{
            return _container
        }
    }
    //容器大小
    var _contentSize:CGSize = CGSizeZero
    var contentSize:CGSize{
        set{
            _contentSize = newValue
            _container.frame.size = _contentSize
        }
        get{
            return _contentSize
        }
    }
    //容器坐标
    var _contentOffset:CGPoint = CGPointZero
    var contentOffset:CGPoint{
        set{
            _contentOffset = newValue
            _container.frame.origin = _contentOffset
        }
        get{
            return _contentOffset
        }
        
    }
    //设置是否可穿透  默认不可穿透
    var _enablePermeability:Bool = false
    var enablePermeability:Bool{
        set{
            _enablePermeability = newValue
        }
        get{
            return _enablePermeability
        }
    }
   
    //是否能够上下滑动
    var _alwaysBounceVertical:Bool = false
    var alwaysBounceVertical:Bool{
        set{
            _alwaysBounceVertical = newValue
        }
        get{
            return _alwaysBounceVertical
        }
    }
    //是否能够左右滑动
    var _alwaysBounceHorizontal:Bool = false
    var alwaysBounceHorizontal:Bool{
        set{
            _alwaysBounceHorizontal = newValue
        }
        get{
            return _alwaysBounceHorizontal
        }
    }
    //是否允许滑动
    var _scrollEnabled:Bool = false
    var scrollEnabled:Bool{
        set{
            _scrollEnabled = newValue
        }
        get{
            return _scrollEnabled
        }
    }
    
   
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
//MARK:touch事件
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesEnded(touches!, withEvent: event)
        
    }
    
    
    
    
    

}
