//
//  ValidationError.m
//  Email Validator
//
//  Created by Jacob Cho on 4/7/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import "ValidationError.h"

@implementation ValidationError

-(id)initWithType:(ErrorType)type {
	self = [super init];
	if (self) {
		self.type = type;
		self.text = [self getTextForErrorType:type];
	}
	return self;
}

+(id)emptyStringError {
	return [[self alloc] initWithType:EmptyString];
}

+(id)invalidUserError {
	return [[self alloc] initWithType:InvalidUser];
}

+(id)missingAtCharacterError {
	return [[self alloc] initWithType:MissingAtChar];
}

+(id)invalidDomainError {
	return [[self alloc] initWithType:InvalidDomain];
}

+(id)invalidEmailError {
	return [[self alloc] initWithType:InvalidEmail];
}

+(id)nonExistentDomainError {
	return [[self alloc] initWithType:NonExistentDomain];
}

+(id)nonExistentError {
	return [[self alloc] initWithType:NonExistent];
}

+(id)lowQualityError {
	return [[self alloc] initWithType:LowQuality];
}

+(id)lowDeliverabilityError {
	return [[self alloc] initWithType:LowDeliverability];
}

+(id)noConnectionError {
	return [[self alloc] initWithType:NoConnection];
}

+(id)timedOutError {
	return [[self alloc] initWithType:TimedOut];
}

+(id)invalidSMTPError {
	return [[self alloc] initWithType:InvalidSMTP];
}

+(id)unavailableSMTPError {
	return [[self alloc] initWithType:UnavaliableSMTP];
}

+(id)unexpectedError {
	return [[self alloc] initWithType:Unexpected];
}

#pragma mark - Private Methods

-(NSString *)getTextForErrorType:(ErrorType)type {
	switch (type) {
		case EmptyString:
			return @"Please enter an email to validate.";
		case InvalidUser:
			return @"The user name in your email is invalid.";
		case MissingAtChar:
			return @"Your email is missing an \"@\" character.";
		case InvalidDomain:
			return @"The email domain in your email is invalid.";
		case InvalidEmail:
			return @"You entered an invalid email, please try again.";
		case NonExistentDomain:
			return @"Sorry, the domain for that email does not exist.";
		case NonExistent:
			return @"Sorry, that email address does not exist.";
		case LowQuality:
			return @"This email address has quality issues and is a risky or low-value address.";
		case LowDeliverability:
			return @"This email address appears to be deliverable, but cannot be guaranteed.";
		case NoConnection:
			return @"Sorry, could not connect to SMTP server.";
		case TimedOut:
			return @"Sorry, the SMTP session timed out.";
		case InvalidSMTP:
			return @"Sorry, the SMTP server returned an unexpected or invalid response.";
		case UnavaliableSMTP:
			return @"Sorry, the SMTP server was unable to process our request.";
		default:
			return @"Sorry, an unexpected error occured";
	}
}

@end
