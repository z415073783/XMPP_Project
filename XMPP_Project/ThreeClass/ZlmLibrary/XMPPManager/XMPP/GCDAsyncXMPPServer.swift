//
//  GCDAsyncXMPPServer.swift
//  XMPP_Project
//
//  Created by zlm on 16/6/30.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit

class GCDAsyncXMPPServer: NSObject,GCDAsyncSocketDelegate {
    
    var xmppQueue:dispatch_queue_t?
    
    static var getInstance:GCDAsyncXMPPServer = GCDAsyncXMPPServer()
    
    override init() {
        super.init()
        self.xmppQueue = dispatch_queue_create("xmpp", DISPATCH_QUEUE_SERIAL)
    }
    
    var _socket:GCDAsyncSocket! = nil
    var socket:GCDAsyncSocket!{
        set{
            _socket = newValue
        }
        get{
            return _socket
        }
    }
    
    //MARK:常量列表
    let HEARTBEAT_INTERVAL_TIME:Double = 30
    
    //MARK:属性列表
    //主机地址
    var _socketHost:String = ""
    var socketHost:String{
        set{
            _socketHost = newValue
        }
        get{
            return _socketHost
        }
    }
    //主机端口
    var _socketPort:UInt16 = 9090
    var socketPort:UInt16{
        set{
            _socketPort = newValue
        }
        get{
            return _socketPort
        }
    }
    //心跳
    var _connectTimer:NSTimer! = nil
    var connectTimer:NSTimer!{
        set{
            _connectTimer = newValue
        }
        get{
            return _connectTimer
        }
    }

    
    /**
     socket连接
     */
    func socketConnectHost() -> Void
    {
        print("\(#function)")
        _socket = GCDAsyncSocket.init(delegate: self, delegateQueue: xmppQueue)
        _socket.delegate = self
        //        var error:NSError! = nil
        do
        {
            
            try _socket.connectToHost(socketHost, onPort: socketPort, withTimeout: 5)
            
            
        }catch
        {
            print("抛出错误/超时")
        }
        //获取数据
        _socket.readDataWithTimeout(30, tag: 0)
        
    }
    func socket(sock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("\(#function)")
        let data:String = "<?xml version='1.0'?>"
        GCDAsyncXMPPServer.getInstance.sendMessageData(data)
        
    }
    func socket(sock: GCDAsyncSocket!, didAcceptNewSocket newSocket: GCDAsyncSocket!) {
        print("\(#function)")
    }
    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        print("\(#function)")
    }
    
    func sendMessageData(message:String) -> Void
    {
        let dataStream = message.dataUsingEncoding(NSUTF8StringEncoding)
        _socket.writeData(dataStream, withTimeout: 5, tag: 1)
        print("\(#function)")
    }
    
    func socketDidCloseReadStream(sock: GCDAsyncSocket!)
    {
        print("\(#function)")
    }
    func socket(sock: GCDAsyncSocket!, didReadPartialDataOfLength partialLength: UInt, tag: Int)
    {
        print("\(#function)")
    }
    func socketDidDisconnect(sock: GCDAsyncSocket!, withError err: NSError!) {
        print("\(#function)")
    }
    
    
}
