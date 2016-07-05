//
//  AppDelegate.swift
//  XMPP_Project
//
//  Created by zlm on 16/6/24.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        
        let rootVC = ViewController.init()
        let nc = UINavigationController.init(rootViewController: rootVC)
        
        self.window?.rootViewController = nc
        
//        MyManager.getInstance.
        
//        var ss:NSString! = "asd"
//        ss = nil
//        print("\(ss.length)")
        
//MARK: socket连接
//        SocketConfigure.getInstance.ipconfig = "10.3.17.240"
//        SocketConfigure.getInstance.port = 9090
//        XMPPServer.getInstance.connet()
        
//MARK: AsyncXMPPServer连接
//        AsyncXMPPServer.getInstance.socketHost = "10.3.17.240"
//        AsyncXMPPServer.getInstance.socketPort = 9090
//        //确保中断连接
//        if AsyncXMPPServer.getInstance.socket != nil {
//            AsyncXMPPServer.getInstance.socket.setUserData(SocketOffline.User.hashValue)
//            AsyncXMPPServer.getInstance.cutOffSocket()
//        }
//        //连接
//        AsyncXMPPServer.getInstance.socketConnectHost()
//        let data:String = "<?xml version='1.0'?><stream:stream xmlns:stream='http://etherx.jabber.org/streams' version='1.0' xmlns='jabber:client' to='yealink.com' xml:lang='en' xmlns:xml='http://www.w3.org/XML/1998/namespace' > "
//        let data:String = "<?xml version='1.0'?>"
//        AsyncXMPPServer.getInstance.sendMessageData(data)
        
//MARK: GCDAsyncXMPPServer连接
//        GCDAsyncXMPPServer.getInstance.socketHost = "10.3.17.240"
//        GCDAsyncXMPPServer.getInstance.socketPort = 9090
//        GCDAsyncXMPPServer.getInstance.socketConnectHost()
//        let data:String = "<?xml version='1.0'?>"
//        GCDAsyncXMPPServer.getInstance.sendMessageData(data)
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

