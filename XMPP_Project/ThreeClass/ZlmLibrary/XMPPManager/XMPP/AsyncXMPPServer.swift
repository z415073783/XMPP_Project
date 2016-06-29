//
//  AsyncXMPPServer.swift
//  XMPP_Project
//
//  Created by zlm on 16/6/28.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit
//MARK:枚举列表
/**
 断开连接类型
 
 - Server: 服务器掉线
 - User:   用户主动cut
 */
enum SocketOffline:Int {
    case Server=0,User
}

class AsyncXMPPServer: NSObject {
    
    static var getInstance:AsyncXMPPServer = AsyncXMPPServer()
    
    var _socket:AsyncSocket! = nil
    var socket:AsyncSocket!{
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
    
//MARK: 方法列表
    /**
     socket连接
     */
    func socketConnectHost() -> Void
    {
        _socket = AsyncSocket.init(delegate: self)
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
    
    
    /**
     心跳函数
     
     - parameter sock: socket套接字
     - parameter host: 主机地址
     - parameter port: 主机端口
     */
    func heartBeat(sock:AsyncSocket,host:String,port:UInt16) -> Void
    {
        print("socket连接成功")
        //心跳30秒连接一次
        connectTimer = NSTimer.scheduledTimerWithTimeInterval(HEARTBEAT_INTERVAL_TIME, target: self, selector: #selector(AsyncXMPPServer.longConnectToSocket), userInfo: nil, repeats: true)
        connectTimer.fire()
    }
    /**
     心跳连接
     */
    func longConnectToSocket() -> Void
    {
        //心跳指令
        let longConnect:String = ""
        let dataStream = longConnect.dataUsingEncoding(NSUTF8StringEncoding)
        _socket.writeData(dataStream, withTimeout: 5, tag: 1)
    }
    //发送消息前先发送字符长度(如果服务器需要)
    func sendMessageLength(message:String) -> Void
    {
        let length:String = String(message.characters.count)
        let dataStream = length.dataUsingEncoding(NSUTF8StringEncoding)
        _socket.writeData(dataStream, withTimeout: 5, tag: 1)
    }
    /**
     发送消息
     
     - parameter message: 消息数据
     */
    func sendMessageData(message:String) -> Void
    {
        let dataStream = message.dataUsingEncoding(NSUTF8StringEncoding)
        _socket.writeData(dataStream, withTimeout: 5, tag: 1)
        
    }
    
    /**
     用户主动切断连接
     */
    func cutOffSocket() -> Void
    {
        _socket.setUserData(SocketOffline.User.hashValue)
        connectTimer.invalidate()
        _socket.disconnect()
    }
    
    override func onSocket(sock: AsyncSocket!, willDisconnectWithError err: NSError!) {
        print("willDisconnectWithError:\(err)")
    }
    
    /**
     断线重连
     
     - parameter sock:
     */
    override func onSocketDidDisconnect(sock: AsyncSocket!) {
        print("sorry the connect is failure \(sock.userData())")
       
        if sock.userData() == SocketOffline.Server.hashValue
        {
            //服务器掉线,重连
            self.socketConnectHost()
        }else if sock.userData() == SocketOffline.User.hashValue
        {
            //用户主动断开,不进行重连
            return;
        }
    }
    /**
     获取数据
     
     - parameter sock: sock
     - parameter data: 数据
     - parameter tag:  tag
     */
    override func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        //得到数据
        print("获得数据:\(data)")
        
        _socket.readDataWithTimeout(30, tag: 0)
    }
    
    override func onSocket(sock: AsyncSocket!, didAcceptNewSocket newSocket: AsyncSocket!) {
        
    }
    override func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        //        NSLog(@"onSocket:%p didConnectToHost:%@ port:%hu",sock,host,port);
        //        [sock readDataWithTimeout:1tag:0];
        print("onSocket:\(sock) didConnectToHost:\(host) port:\(port)")
    }
    override func onSocket(sock: AsyncSocket!, didWriteDataWithTag tag: Int)
    {
        
    }
    override func onSocketDidSecure(sock: AsyncSocket!) {
        
    }
    
    
    
    
    
}
