//
//  ValidationService.m
//  Email Validator
//
//  Created by Jacob Cho on 4/4/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import "ValidationService.h"

@implementation ValidationService

static NSString *apiKey = @"test_e1d44ae362fffcb64c94d74c6f8e4fb834e02491e9e93f6c284e7c9ad5e6ad44";
static NSString *baseURL = @"https://api.kickbox.com/v2/";

+(instancetype)sharedInstance {
	static ValidationService *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[ValidationService alloc] init];
	});
	
	return sharedInstance;
}

-(void)validateEmail:(NSString *)email completion:(void (^)(ValidationResponse *reponse, NSError *error))completionHandler {
	NSString *url = [NSString stringWithFormat:@"%@verify?email=%@&apikey=%@", baseURL, email, apiKey];
	[self getRequest:url completion:^(NSDictionary *responseDict, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			ValidationResponse *response = [[ValidationResponse alloc] initWithDict:responseDict];
			completionHandler(response, error);
		});
	}];
}

-(void)getRequest:(NSString *)url completion:(void (^)(NSDictionary *responseDict, NSError *error))completionHandler {
	NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	[urlRequest setHTTPMethod:@"GET"];
	
	NSURLSession *session = [NSURLSession sharedSession];
	
	NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
	{
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
		if(httpResponse.statusCode == 200)
		{
			NSError *error = nil;
			NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
			completionHandler(responseDictionary, error);
		}
		else
		{
			completionHandler(nil, error);
		}
	}];
	[dataTask resume];
}

@end
