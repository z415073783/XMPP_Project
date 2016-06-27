//
//  NewChatManage.h
//  QingTalk
//
//  Created by 曾亮敏 on 15/11/26.
//  Copyright © 2015年 zlm. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(int, SendType)
{
    send_company,
    send_department,
    send_user,
    send_public_user,
    send_public_department,
    send_public_company,
    send_talk_user,
    send_talk_department,
    send_talk_company
};
typedef enum
{
    type_message,
    type_file

}messageType;
@interface NewChatManage : NSObject
{
    NSMutableDictionary* sendDataList;
    
    
    
}
+(NewChatManage*)getInstance;
+(void)sendMessage:(NSString *)message Type:(messageType)type SendType:(SendType)sendType SendId:(NSString*)sendId TimeLength:(NSString*)timeLength;
+(void)returnChatData:(NSDictionary*)data Code:(int)code;
@end
