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
    private var _container:UIView = UIView()
    var container:UIView{
//        set{
//            _container = newValue
//        }
        get{
            return _container
        }
    }
    //容器大小
    private var _contentSize:CGSize = CGSizeZero
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
    private var _contentOffset:CGPoint = CGPointZero
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
    private var _enablePermeability:Bool = false
    var enablePermeability:Bool{
        set{
            _enablePermeability = newValue
        }
        get{
            return _enablePermeability
        }
    }
   
    //是否能够上下滑动
    private var _alwaysBounceVertical:Bool = true
    var alwaysBounceVertical:Bool{
        set{
            _alwaysBounceVertical = newValue
        }
        get{
            return _alwaysBounceVertical
        }
    }
    //是否能够左右滑动
    private var _alwaysBounceHorizontal:Bool = true
    var alwaysBounceHorizontal:Bool{
        set{
            _alwaysBounceHorizontal = newValue
        }
        get{
            return _alwaysBounceHorizontal
        }
    }
    //是否允许滑动
    private var _scrollEnabled:Bool = true
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
        self.addSubview(_container)
        self.multipleTouchEnabled = true
        self.clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK:touch事件
    var firstPoint:CGPoint!  //touch事件开始坐标
    var currentPoint:CGPoint! //touch事件当前坐标
    var beginPos:CGPoint! //container开始位置
//    var touchTime
//MARK:touch事件处理
    //touch开始
    func touchBegin(touches: Set<UITouch>, withEvent event: UIEvent?) -> Void
    {
        if !_scrollEnabled{return}
        if isAction{return}
        firstPoint = touches.first?.locationInView(self)
        beginPos = _container.frame.origin
        
    }
    //touch移动
    func touchMove(touches: Set<UITouch>, withEvent event: UIEvent?) -> Void
    {
        if !_scrollEnabled{return}
        if isAction{return}
        currentPoint = touches.first?.locationInView(self)
        //偏移量
        var offsetX = currentPoint.x-firstPoint.x
        var offsetY = currentPoint.y-firstPoint.y
        if !_alwaysBounceHorizontal || _container.frame.size.width < self.frame.size.width
        {
            offsetX = 0
        }
        if !_alwaysBounceVertical || _container.frame.size.height < self.frame.size.height
        {
            offsetY = 0
        }
        //边缘处理
        
        
        
        //设置坐标
        _container.frame.origin = CGPointMake(beginPos.x+offsetX, beginPos.y+offsetY)
    }
    //touch结束
    func touchEnd(touches: Set<UITouch>, withEvent event: UIEvent?) -> Void
    {
        if !_scrollEnabled{return}
        if isAction{return}
        
        //位移变量
        let endPoint:CGPoint = (touches.first?.locationInView(self))!
        var offsetX = endPoint.x - currentPoint.x
        var offsetY = endPoint.y - currentPoint.y
        var nextOrigin:CGPoint = CGPointMake(_container.frame.origin.x+offsetX, _container.frame.origin.y+offsetY)
        
        if _container.frame.size.width > self.frame.size.width
        {
            //回弹处理x
            if _container.frame.origin.x>0
            {
                moveAction(CGPointMake(0, _container.frame.origin.y))
            }else
            {
                //位移处理
                
                
                
            }
            if _container.frame.origin.x < -(_container.frame.size.width-self.frame.size.width)
            {
                moveAction(CGPointMake(-(_container.frame.size.width-self.frame.size.width), _container.frame.origin.y))
            }else
            {
                //位移处理
                
            }
        }
        if _container.frame.size.height > self.frame.size.height
        {
            //回弹处理y
            if _container.frame.origin.y>0
            {
                moveAction(CGPointMake(_container.frame.origin.x, 0))
            }else
            {
                //位移处理
                
            }
            if _container.frame.origin.y < -(_container.frame.size.height-self.frame.size.height)
            {
                moveAction(CGPointMake(_container.frame.origin.x,-(_container.frame.size.height-self.frame.size.height)))
            }else
            {
                //位移处理
                
            }
        }
    }
    //计时器
    func update() -> Void
    {
        
        
        
        
        
    }
    
    
    
    //MARK:回弹动画
    var isAction:Bool = false
    func moveAction(goalPos:CGPoint) -> Void
    {
        isAction = true
        weak var ss = self
        UIView.animateKeyframesWithDuration(0.2, delay: 0, options: UIViewKeyframeAnimationOptions.LayoutSubviews, animations: {
                ss!._container.frame.origin = goalPos
            })
            { (true) in
                ss!.isAction = false
            }
    }
    
    
    
    
    //MARK: 父类重载touch方法
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        touchBegin(touches, withEvent: event)
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        touchMove(touches, withEvent: event)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        touchEnd(touches, withEvent: event)
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesEnded(touches!, withEvent: event)
        touchEnd(touches!, withEvent: event)
    }


}
