//
//  ValidationResponse.h
//  Email Validator
//
//  Created by Jacob Cho on 4/4/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationError.h"

@interface ValidationResponse : NSObject

@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSString *reason;
@property (assign, nonatomic) BOOL role;
@property (assign, nonatomic) BOOL free;
@property (assign, nonatomic) BOOL disposable;
@property (assign, nonatomic) BOOL acceptAll;
@property (strong, nonatomic) NSString *didYouMean;
@property (strong, nonatomic) NSNumber *sendEx;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *domain;
@property (assign, nonatomic) BOOL success;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) ValidationError *validationError;

-(id)initWithDict:(NSDictionary *)dict;

@end
