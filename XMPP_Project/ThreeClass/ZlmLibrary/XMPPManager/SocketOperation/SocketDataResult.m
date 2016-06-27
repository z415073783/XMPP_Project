//
//  SocketDataResult.m
//  QingTalk
//
//  Created by 曾亮敏 on 15/11/26.
//  Copyright © 2015年 zlm. All rights reserved.
//

#import "SocketDataResult.h"
#import "ServerSocket.h"
#import "NewChatManage.h"
@implementation SocketDataResult
+(void)SocketReturn:(NSDictionary*)data
{
    //    拆分数据
    NSInteger code = [[data objectForKey:@"code"]integerValue];
    switch (code) {
        case messageType_init_return:
        {
            NSInteger isSuccess = [[data objectForKey:@"isSuccess"]integerValue];
            if (isSuccess == 0)
            {
                [[ServerSocket getInstance] setClientType:ClientType_OFF];
            }
        }
            break;
            case messageType_chat_return:
        {
            [NewChatManage returnChatData:data Code:code];
        }
            break;
        case messageType_chat:
        {
            [NewChatManage returnChatData:data Code:code];
        }
            break;
            
        default:
            break;
    }
}
@end
