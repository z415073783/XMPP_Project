//
//  ServerSocket.h
//  SocketTest
//
//  Created by 曾亮敏 on 15/11/2.
//  Copyright © 2015年 曾亮敏. All rights reserved.
//

#import <Foundation/Foundation.h>
//#include <stdio.h>
//#include <string.h>
//using namespace std;
//enum
//{
//    ClientType_OFF,
//    ClientType_ON
//    
//}ClientType;
@interface ServerSocket : NSObject
{
//@protected
    //客户端编号
//    int sockfd;
//    //接收信息数据
//    NSMutableArray* resultArr;
////    int _clientType;
//    NSTimer* _timer;
}
//@property (nonatomic) int clientType;
//
//@property int breathTime;

//+(int)socketConnect:(char *)server Port:(int)serverPort
//+(ServerSocket*)getInstance;
//+(void)beginLoginWithAccount:(NSString*)accounts Password:(NSString*)password;
//+(void)initSocketDataWithAccount:(NSString*)accounts Password:(NSString*)password;
//+(void)sendMessage:(NSString*)message;
//+(void)closeSocket;
//
//-(void)sendBreathMethod;

//内部方法
int connect_socket(char * server,int serverPort);
int send_msg(int sockfd,const char * sendBuff);
char* recv_msg(int sockfd);
int close_socket(int sockfd);

@end
