//
//  NewChatManage.m
//  QingTalk
//
//  Created by 曾亮敏 on 15/11/26.
//  Copyright © 2015年 zlm. All rights reserved.
//

#import "NewChatManage.h"
//#import "UserManage.h"
//#import "ChatManage.h"
#import "ServerSocket.h"
@implementation NewChatManage
+(NewChatManage*)getInstance
{
    static NewChatManage* shared = nil;
    if (shared == nil)
    {
        shared = [[NewChatManage alloc]init];
    }
    return shared;
}

+(void)sendMessage:(NSString *)message toUser:(NSString *)user Type:(messageType)type SendType:(SendType)sendType SendId:(NSString*)sendId TimeLength:(NSString*)timeLength MessageId:(NSString*)messageId{
    //发送格式departType_type_time_body 接收者类型_消息类型_时间_消息

    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSString stringWithFormat:@"%d",sendType] forKey:@"sendType"];
    [dic setValue:[NSString stringWithFormat:@"%d",type] forKey:@"type"];//文件或文字
//    [dic setValue:[NSString stringWithFormat:@"%f",currentTimes] forKey:@"currentTimes"];
    [dic setValue:sendId forKey:@"sendId"];
    [dic setValue:timeLength forKey:@"timeLength"];
    [dic setValue:[UserManage getInstance].userName forKey:@"userName"];
    [dic setValue:[UserManage getInstance].jobName?[UserManage getInstance].jobName:@"" forKey:@"jobName"];
    [dic setValue:message forKey:@"message"];
    [dic setValue:messageId forKey:@"messageId"];
    
    [dic setValue:[NSString stringWithFormat:@"%d",messageType_chat] forKey:@"code"];
    
//     //数据加密
//    NSData* data2 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSString* data = [data2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [[NewChatManage getInstance]->sendDataList setObject:dic forKey:messageId];
    
//发送数据
    [ServerSocket sendMessage:dic];
    
    
}
//发送信息
+(void)sendMessage:(NSString *)message Type:(messageType)type SendType:(SendType)sendType SendId:(NSString*)sendId TimeLength:(NSString*)timeLength
{
    
    NSDate* date = [NSDate init];
    NSString* messageId = [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    [NewChatManage sendMessage:message toUser:sendId Type:type SendType:sendType SendId:sendId TimeLength:(NSString*)timeLength MessageId:messageId];
    
//    NSMutableDictionary* sendData = [NSMutableDictionary dictionary];
//    [sendData setValue:[NSString stringWithFormat:@"%d",sendType] forKey:@"type"];
//    [sendData setValue:sendId forKey:@"sendId"];
//    [NetWorkManage sendPostRequest:sendData Trade:@"index" Port:26 Block:^(id resultData, NSError *error) {
//        if ([[resultData objectForKey:@"isSuccess"]intValue] == 1)
//        {
//            NSString* messageId = [resultData objectForKey:@"messageId"];
//            [NewChatManage sendMessage:message toUser:sendId Type:type SendType:sendType SendId:sendId TimeLength:(NSString*)timeLength MessageId:messageId];
    
    
//        }
//    }];
}
//信息状态返回
+(void)returnChatData:(NSDictionary*)data Code:(int)code
{
//    取出客户端上传的唯一标识符
//    NSDate* currentTime = [NSDate date];
//    NSTimeInterval currentTimes = [currentTime timeIntervalSince1970];
    NSDictionary* messageData;
    long currentTimes;
    if (code == messageType_chat_return)
    {
        NSString* mark = [data objectForKey:@"messageId"];
        //根据标识符取出数据
        messageData = [[NewChatManage getInstance]->sendDataList objectForKey:mark];
        
        currentTimes = [[data objectForKey:@"currentTimes"]longValue];
//        判断是否成功
        if([[data objectForKey:@"isSuccess"] intValue] == 0)
        {
//            发送失败
            
        }
    }else
    {
        messageData = data;
        currentTimes = [[messageData objectForKey:@"currentTimes"]longValue];
    }
//    currentTimes = [[data objectForKey:@"currentTimes"]longValue];
    int sendType = [[messageData objectForKey:@"sendType"]intValue];
    int type = [[messageData objectForKey:@"type"] intValue];
    NSString* sendId = [messageData objectForKey:@"sendId"];
    NSString* timeLength = [messageData objectForKey:@"timeLength"];
    NSString* message = [messageData objectForKey:@"message"];
    
    
    if (send_user == sendType)
    {
        [[ChatManage getInstance]receiveChatDataWithSender:sendId SendType:(SendType)sendType MessageType:(messageType)type IsUser:code==messageType_chat_return?YES:NO SendTime:(int)currentTimes Body:message TimeLength:timeLength SendName:[NSString stringWithFormat:@"%@%@",[UserManage getInstance].userName,[UserManage getInstance].jobName?[UserManage getInstance].jobName:@""]];
    }
    //返回判断
    if (send_user != sendType)
    {
        NSDate* currentTime = [NSDate date];
        NSTimeInterval currentTimes = [currentTime timeIntervalSince1970];
        
        //保存发送消息
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        dispatch_async(queue, ^{
            //        通知or喊话
            [[ChatManage getInstance]receivePublicMessageWithPlayer:[NSString stringWithFormat:@"%@",sendId] SendId:sendId SendType:sendType MessageType:type IsUser:code==messageType_chat_return?YES:NO SendTime:currentTimes Body:message TimeLength:timeLength SendName:[NSString stringWithFormat:@"%@%@",[UserManage getInstance].userName,[UserManage getInstance].jobName]];
        });
    }
    
    
}




@end
