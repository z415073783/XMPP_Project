//
//  XMPPServer.swift
//  XMPP_Project
//
//  Created by zlm on 16/6/27.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit

class XMPPServer: NSObject {
    /**
     枚举 客户端状态
     
     - ClientType_ON:  客户端开启
     - ClientType_OFF: 客户端关闭
     */
    enum ClientType {
        case ClientType_ON,ClientType_OFF
    }
    static let getInstance:XMPPServer = XMPPServer()
    
    var _clientType:ClientType = ClientType.ClientType_OFF
    var clientType:ClientType{
        set{
            _clientType = newValue
        }
        get{
            return _clientType
        }
    }
    //客户端编号
    var _sockfd:Int32 = 0
    var sockfd:Int32{
        set{
            _sockfd = newValue
        }
        get{
            return _sockfd
        }
    }
    //接收信息数据
    var _resultArr:NSMutableArray? = nil
    var resultArr:NSMutableArray?{
        set{
            _resultArr = newValue
        }
        get{
            return _resultArr!
        }
    }
    
    //计时器
    var _timer:NSTimer? = nil
    var timer:NSTimer?{
        set{
            _timer = newValue
        }
        get{
            return _timer!
        }
    }
    //客户端定时发送数据时间间隔
    var _breathTime:Double=3
    var breathTime:Double{
        set{
            _breathTime = newValue
        }
        get{
            return _breathTime
        }
    }
    /**
     连接服务器
     */
    func connet() -> Void
    {
        _sockfd = 0;
        //连接服务器
        _sockfd = connect_socket(UnsafeMutablePointer.init(SocketConfigure.getInstance.ipconfig.UTF8String), SocketConfigure.getInstance.port)
        //设置客户端状态为ON
        _clientType = ClientType.ClientType_ON
        
        if (_timer == nil)
        {
            //    开计时器
            _timer = NSTimer.init(timeInterval: _breathTime, target: XMPPServer.getInstance, selector: #selector(XMPPServer.sendBreathMethod), userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(_timer!, forMode: NSDefaultRunLoopMode)
        }
        
        //初始化数据
        let connetStr:String = getConnetStr()
        
        sendMessageWithString(connetStr)//发送数据
        
        var res:UnsafeMutablePointer<Int8>
        res=recv_msg(_sockfd);
        print("recv_msg:\(res)")
    }
    /**
     拼接连接字符流
     
     - returns: 返回连接字符流
     */
    func getConnetStr() -> String
    {

        return "<stream:stream to=\""+(SocketConfigure.getInstance.ipconfig as String)+"\" xmlns=\"jabber:client\" xmlns:stream=\"http://etherx.jabber.org/streams\" version=\"1.0\" > "
    }
    
    /**
     呼吸函数 定时调用
     */
    func sendBreathMethod()-> Void
    {
        if _clientType != ClientType.ClientType_ON
        {
            if (_timer != nil)
            {
                _timer?.invalidate()
                _timer = nil
            }
            return;
        }
        //发送数据
//        let connetStr:String = getConnetStr()
//        sendMessageWithString(connetStr)
        
    }
    /**
     发送字符串数据
     
     - parameter message: 要发送的字符串
     */
    func sendMessageWithString(message:NSString?) ->Void
    {
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        dispatch_async(queue) { 
            if XMPPServer.getInstance.clientType != ClientType.ClientType_ON
            {
                return
            }
            if message != nil && message!.length>0
            {
                let result:Int32 = send_msg(XMPPServer.getInstance.sockfd, (message?.UTF8String)!)
                if result == -1
                {
                    //发送失败
                    print("消息发送失败")
                }
            }
        }
    }
    /**
     发送对象数据
     */
    class func sendMessage()->Void
    {
        
    }
    
    /**
     信息返回
     
     - parameter result: 网络数据
     */
    func messageReturn(result:NSString) -> Void
    {
        print("数据返回:\(result)")
    }
    /**
     关闭客户端连接
     */
    func closeSocket() -> Void
    {
        //向服务器发送关闭请求
        
        
        //客户端连接关闭方法
        close_socket(XMPPServer.getInstance.sockfd)
        if (XMPPServer.getInstance.timer != nil)
        {
            XMPPServer.getInstance.timer?.invalidate()
            XMPPServer.getInstance.timer = nil
        }
    }
    

    
    

    
}
