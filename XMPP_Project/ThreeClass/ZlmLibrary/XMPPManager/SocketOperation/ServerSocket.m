//
//  ServerSocket.m
//  SocketTest
//
//  Created by 曾亮敏 on 15/11/2.
//  Copyright © 2015年 曾亮敏. All rights reserved.
//

#import "ServerSocket.h"
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/shm.h>

#include   <sys/stat.h>
#include   <netdb.h>
#import "XMPP_Project-Swift.h"
#import <CommonCrypto/CommonDigest.h>
//#import "SocketDataResult.h"

#define    RES_LENGTH  10240 //接受字符的最大长度

#define MESSAGETYPE_BREATH @""
#define MESSAGETYPE_EXIT   @"\0"  //socket关闭数据


@implementation ServerSocket

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/************************************************************
 * 连接SOCKET服务器，如果出错返回-1，否则返回socket处理代码
 * server：服务器地址(域名或者IP),serverport：端口
 * ********************************************************/
int connect_socket(char * server,int serverPort){
    int    sockfd=0;
    struct    sockaddr_in    addr;
    struct    hostent        * phost;
    //向系统注册，通知系统建立一个通信端口
    //AF_INET表示使用IPv4协议   AF_INET6 为IPv6协议
    //SOCK_STREAM表示使用TCP协议
    if((sockfd=socket(AF_INET,SOCK_STREAM,0))<0){
        herror("Init socket error!");
        return -1;
    }
    
    bzero(&addr,sizeof(addr));
    addr.sin_family=AF_INET;
    addr.sin_port=htons(serverPort);
    addr.sin_addr.s_addr=inet_addr(server);//按IP初始化
//    bind(sockfd, &addr, sizeof(sockaddr))
    if(addr.sin_addr.s_addr == INADDR_NONE){//如果输入的是域名
        phost = (struct hostent*)gethostbyname(server);
        if(phost==NULL){
            herror("Init socket s_addr error!");
            return -1;
        }
        addr.sin_addr.s_addr =((struct in_addr*)phost->h_addr)->s_addr;
    }
    if(connect(sockfd,(struct sockaddr*)&addr,sizeof(addr))<0)
        return -1;//0表示成功，-1表示失败
    else
        return sockfd;
    
}

/**************************************************************
 * 发送消息，如果出错返回-1，否则返回发送的字符长度
 * sockfd：socket标识，sendBuff：发送的字符串
 * *********************************************************/
int send_msg(int sockfd,const char * sendBuff){
    int    sendSize=0;
    if((sendSize=send(sockfd,sendBuff,strlen(sendBuff),0))<=0){
        herror("Send msg error!");
        return -1;
    }else
        return sendSize;
}

/****************************************************************
 *接受消息，如果出错返回NULL，否则返回接受字符串的指针(动态分配，注意释放)
 *sockfd：socket标识
 * *********************************************************/
char * recv_msg(int sockfd){
    char * response;
    int  flag=0,recLenth=0;
    response=(char *)malloc(RES_LENGTH);
    memset(response,0,RES_LENGTH);
    for(flag=0;;){
        if((recLenth=recv(sockfd,response+flag,RES_LENGTH-flag,0))==-1){
            free(response);
            herror("Recv msg error!");
            return NULL;
        }else if(recLenth==0)
            break;
        else{
            [[XMPPServer getInstance] messageReturn:[NSString stringWithUTF8String:response]];
            flag+=recLenth;
            recLenth=0;
        }
    }
    response[flag]='/0';
    return response;
}
/**************************************************
 *关闭连接
 * **********************************************/
int    close_socket(int sockfd){
//    send_msg(sockfd, "exit\n");//发送关闭信息
    close(sockfd);
    return 0;
}

@end
