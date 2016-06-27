//
//  SocketConfigure.swift
//  XMPP_Project
//
//  Created by zlm on 16/6/27.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit

class SocketConfigure: NSObject {

//    #define MYPORT 9090
//    #define Ipconfig "10.3.17.240"
    static let getInstance:SocketConfigure = SocketConfigure()
    
    var _port:Int32 = 9090
    var port:Int32{
        set{
            _port = newValue
        }
        get{
            return _port
        }
    }
    var _ipconfig:NSString = ""
    var ipconfig:NSString{
        set{
            _ipconfig = newValue
        }
        get{
            return _ipconfig
        }
    }
    
    
    
    
    
}
