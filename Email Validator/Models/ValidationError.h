//
//  ValidationError.h
//  Email Validator
//
//  Created by Jacob Cho on 4/7/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ErrorType {
	EmptyString,
	InvalidUser,
	MissingAtChar,
	InvalidDomain,
	InvalidEmail,
	NonExistentDomain,
	NonExistent,
	LowQuality,
	LowDeliverability,
	NoConnection,
	TimedOut,
	InvalidSMTP,
	UnavaliableSMTP,
	Unexpected
}ErrorType;

@interface ValidationError : NSObject

@property (assign, nonatomic) ErrorType type;
@property (strong, nonatomic) NSString *text;

-(id)initWithType:(ErrorType)type;
+(id)emptyStringError;
+(id)invalidUserError;
+(id)missingAtCharacterError;
+(id)invalidDomainError;
+(id)invalidEmailError;
+(id)nonExistentDomainError;
+(id)nonExistentError;
+(id)lowQualityError;
+(id)lowDeliverabilityError;
+(id)noConnectionError;
+(id)timedOutError;
+(id)invalidSMTPError;
+(id)unavailableSMTPError;
+(id)unexpectedError;

@end
