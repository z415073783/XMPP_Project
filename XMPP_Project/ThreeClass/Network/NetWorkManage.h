//
//  NetWorkManage.h
//  NetWorkProject
//
//  Created by Zlm on 15-4-10.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    Application_json_charset_utf8,
    Application_x_www_form_urlencoded,
    Application_multipart_form_data,
    Application_text_html_charset_utf8
    
}ContentType;
typedef NS_ENUM(NSInteger, DataCodeType)
{
    DefaultType,
    Base64Type,
    
};
typedef NS_ENUM(NSInteger, ProgressType)
{
    DefaultNoType,
    StateOneType,
    StateTwoType
};
typedef NS_ENUM(NSInteger, ApplicationType)
{
    Application_DefaultType
    
    
};
typedef NS_ENUM(NSInteger, DataSplitType)
{
    DataSplit_JSON,
    DataSplit_Urlencoded
};


@interface NetWorkManage : NSObject
{
    @private
}
@property(nonatomic)NSString* ipconfig;
@property(nonatomic)NSMutableURLRequest* request;
@property(nonatomic)NSMutableURLRequest* getRequest;
@property(nonatomic)NSString* contentType;
@property(nonatomic)int timeout;
@property(nonatomic)DataCodeType dataType;
//@property(nonatomic)BOOL svProgressType;
@property(nonatomic)ApplicationType zApplicationType;
@property(nonatomic)DataSplitType dataSplit;//数据拼接方式  默认json
@property(assign)NSString* errorReturn;
+(NetWorkManage*)getInstance;
#pragma mark -网络请求配置-
/*设置网络请求ip或域名 例:192.168.1.1:8081*/
+(void)setIpconfig:(NSString*)ipconfig;
/*设置用户名和密码*/
+(void)setUserName:(NSString*)userName Password:(NSString*)password;
/*设置数据类型 默认utf8*/
+(void)setContentType:(ContentType)sender;
/*设置请求超时时间  默认10秒*/
+(void)setTimeoutInterval:(int)sender;
/*设置数据解码类型 默认不转码*/
//+(void)setDataCodeType:(DataCodeType)type;
/*设置是否隐藏风火轮*/
//+(void)setSVProgressHUDIsHide:(BOOL)hide;
/*设置应用特殊条件*/
//+(void)setApplicationType:(ApplicationType)type;

#pragma mark -网络请求接口-
/*GET请求
 data:数据
 trade:链接头
 */
+(void)sendGetRequest:(NSDictionary*)data Trade:(NSString*)trade Block:(void(^)(id resultData,NSError* error))resultBlock;
/*POST请求*/
+(void)sendPostRequest:(NSDictionary*)data Trade:(NSString*)trade Block:(void(^)(id resultData,NSError* error))resultBlock;

@end
