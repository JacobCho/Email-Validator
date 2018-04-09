//
//  ValidationResponse.m
//  Email Validator
//
//  Created by Jacob Cho on 4/4/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import "ValidationResponse.h"

@implementation ValidationResponse

-(id)initWithDict:(NSDictionary *)dict {
	self = [super init];
	if (self) {
		self.result = dict[@"result"];
		self.reason = dict[@"reason"];
		self.role = dict[@"role"];
		self.free = dict[@"free"];
		self.disposable = dict[@"disposable"];
		self.acceptAll = dict[@"accept_all"];
		self.didYouMean = dict[@"did_you_mean"];
		self.sendEx = dict[@"sendex"];
		self.email = dict[@"email"];
		self.user = dict[@"user"];
		self.domain = dict[@"domain"];
		self.success = dict[@"success"];
		self.message = dict[@"message"];
		[self processValidationError];
	}
	return self;
}

-(void)processValidationError {
	NSString *reason = self.reason;
	if ([reason isEqualToString:@"accepted_email"]) {
		return;
	}
	
	if ([reason isEqualToString:@"invalid_email"]) {
		self.validationError = [ValidationError invalidEmailError];
	} else if ([reason isEqualToString:@"invalid_domain"]) {
		self.validationError = [ValidationError nonExistentDomainError];
	} else if ([reason isEqualToString:@"rejected_email"]) {
		self.validationError = [ValidationError nonExistentError];
	} else if ([reason isEqualToString:@"low_quality"]) {
		self.validationError = [ValidationError lowQualityError];
	} else if ([reason isEqualToString:@"low_deliverability"]) {
		self.validationError = [ValidationError lowDeliverabilityError];
	} else if ([reason isEqualToString:@"no_connect"]) {
		self.validationError = [ValidationError noConnectionError];
	} else if ([reason isEqualToString:@"timeout"]) {
		self.validationError = [ValidationError timedOutError];
	} else if ([reason isEqualToString:@"invalid_smtp"]) {
		self.validationError = [ValidationError invalidSMTPError];
	} else if ([reason isEqualToString:@"unavailable_smtp"]) {
		self.validationError = [ValidationError unavailableSMTPError];
	} else {
		self.validationError = [ValidationError unexpectedError];
	}
}

@end
