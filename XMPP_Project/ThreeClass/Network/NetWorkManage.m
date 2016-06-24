//
//  NetWorkManage.m
//  NetWorkProject
//
//  Created by Zlm on 15-4-10.
//  Copyright (c) 2015年 zlm. All rights reserved.
//

#import "NetWorkManage.h"
@implementation NetWorkManage
+(NetWorkManage*)getInstance
{
    static NetWorkManage* shared = nil;
    if (shared == nil)
    {
        shared = [[NetWorkManage alloc]init];
        [shared setRequest:[[NSMutableURLRequest alloc]init]];
        [shared.request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [shared setGetRequest:[[NSMutableURLRequest alloc]init]];
        [shared.getRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [shared setDataSplit:DataSplit_JSON];
        [NetWorkManage setTimeoutInterval:15];
        //默认ContentType
        [NetWorkManage setContentType:Application_json_charset_utf8];
        [NetWorkManage setDataCodeType:DefaultType];
//        [NetWorkManage setSVProgressHUDIsHide:NO];
        [NetWorkManage setApplicationType:Application_DefaultType];
//        [NetWorkWithAFManage getInstance];
        [shared setErrorReturn:@"网络连接失败,请检查您的网络是否正常"];
    }
    return shared;
}
+(void)setIpconfig:(NSString *)ipconfig
{
    [[NetWorkManage getInstance] setIpconfig:ipconfig];
//    [[NetWorkWithAFManage getInstance] setIpconfig:ipconfig];
}
+(void)setUserName:(NSString *)userName Password:(NSString *)password
{
    
    if (!userName || userName.length == 0)
    {
        [[NetWorkManage getInstance].request setValue:nil
                                   forHTTPHeaderField:@"Authorization"];
        return;
    }
/*    
    if (password && password.length>0)
    {
        password = [WholeDefine md5:password];
    }
*/
    NSString* baseEncodedData = [[[NSString stringWithFormat:@"%@:%@",userName,password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    [[NetWorkManage getInstance].request setValue:[NSString stringWithFormat:@"%@ %@", @"Basic", baseEncodedData]
   forHTTPHeaderField:@"Authorization"];
    //配置AFNetworking
//    [NetWorkWithAFManage setUserName:userName PassWord:password];
}
+(void)setTimeoutInterval:(int)sender
{
    [[NetWorkManage getInstance] setTimeout:sender];
    [[NetWorkManage getInstance].request setTimeoutInterval:sender];
    [[NetWorkManage getInstance].getRequest setTimeoutInterval:sender];
}
+(void)setContentType:(ContentType)sender
{
    switch (sender)
    {
        case Application_json_charset_utf8:
        {
            [[NetWorkManage getInstance] setContentType:@"application/json; charset=utf-8"];
        }
            break;
        case Application_x_www_form_urlencoded:
        {
            [[NetWorkManage getInstance] setContentType:@"application/x-www-form-urlencoded"];
        }
            break;
        case Application_multipart_form_data:
        {
            [[NetWorkManage getInstance] setContentType:@"multipart/form-data"];
        }
            break;
        case Application_text_html_charset_utf8:
        {
            [[NetWorkManage getInstance] setContentType:@"text/html;charset=utf-8"];

        }
        default:
            break;
    }
    [[NetWorkManage getInstance].request setValue:[NetWorkManage getInstance].contentType forHTTPHeaderField:@"Content-type"];
    
}
+(void)setDataCodeType:(DataCodeType)type
{
    [[NetWorkManage getInstance] setDataType:type];
}
+(void)sendGetRequest:(NSDictionary *)data Trade:(NSString *)trade Block:(void (^)(id, NSError *))resultBlock
{
    
    //数据解析
    NSMutableString* dataStr = [NSMutableString string];
    
    [dataStr appendFormat:@"?"];
    if (data)
    {
        NSArray* allKey = [data allKeys];
        
        for (int i = 0; i<[allKey count]; i++)
        {
            [dataStr appendFormat:@"%@=%@",[allKey objectAtIndex:i],[data objectForKey:[allKey objectAtIndex:i]]];
            if (i < [allKey count] - 1)
            {
                [dataStr appendString:@"&"];
            }
        }
    }
    //拼接链接
    NSURL* url = [NSURL URLWithString:[[NSMutableString stringWithFormat:@"http://%@/%@%@",[NetWorkManage getInstance].ipconfig,trade,dataStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* request = [NetWorkManage getInstance].getRequest;
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSession* session = [NSURLSession sharedSession];
   
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            id result = [NetWorkManage dataDecodeWithType:[NetWorkManage getInstance].dataType Data:data];
            [NetWorkManage isError:error]?nil:resultBlock(result,error);
        });
    } ];
    //开始任务
    [task resume];
}

+(void)sendPostRequest:(NSDictionary *)data Trade:(NSString *)trade Block:(void (^)(id, NSError *))resultBlock
{
    //拼接链接
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@",[NetWorkManage getInstance].ipconfig,trade]];
    NSMutableURLRequest* request = [NetWorkManage getInstance].request;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    if(!data)
    {
        data = [[NSMutableDictionary alloc]init];
    }
//    [data setValue:[NSString stringWithFormat:@"%d",port] forKey:@"port"];
    
    if (data)
    {
        switch ([NetWorkManage getInstance].dataSplit)
        {
            case DataSplit_JSON:
            {
                NSError* error;
                [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error]];
            }
                break;
            case DataSplit_Urlencoded:
            {
                NSMutableString* dataStr = [NSMutableString string];
                if (data)
                {
                    NSArray* allKey = [data allKeys];
                    
                    for (int i = 0; i<[allKey count]; i++)
                    {
                        [dataStr appendFormat:@"%@=%@",[allKey objectAtIndex:i],[data objectForKey:[allKey objectAtIndex:i]]];
                        if (i < [allKey count] - 1)
                        {
                            [dataStr appendString:@"&"];
                        }
                    }
                }
                [request setHTTPBody:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];
            }
                break;
            default:
                break;
        }
    }
    NSLog(@"url:%@",url);
    
    NSURLSession* session = [NSURLSession sharedSession];
    //    session
//    if ([SVProgressHUD isVisible] == false && [NetWorkManage getInstance].svProgressType == YES)
//    {
//        [SVProgressHUD show];
//        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//    }
//    NSLog(@"allHTTPHeaderFields:%@",request.allHTTPHeaderFields);
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"receiveData:%@ ----\nresponse:%@ ----\n error:%@",data,response,error);
            
          
            id result = [NetWorkManage dataDecodeWithType:[NetWorkManage getInstance].dataType Data:data];
            [NetWorkManage isError:error]?nil:resultBlock(result,error);
//            if ([NetWorkManage getInstance].svProgressType == YES)
//            {
//                [SVProgressHUD dismiss];
//            }
            
        });
    } ];
    //开始任务
    [task resume];
}

+(id)dataDecodeWithType:(DataCodeType)type Data:(NSData*)data
{
    if (!data) {
        return nil;
    }

    NSError* error = nil;
    if (!data)
    {
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return result;
}
+(BOOL)isError:(NSError*)error
{
    /*
    if (error)
    {
        NSString* code = [error.userInfo objectForKey:@"_kCFStreamErrorCodeKey"];
        if ([code intValue] == -2102)
        {
            
             UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:[NetWorkManage getInstance].errorReturn delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alert show];
             
            return YES;
        }
    }
    */
    return NO;
}

+(void)setApplicationType:(ApplicationType)type
{
    [[NetWorkManage getInstance] setZApplicationType:type];
}

@end
