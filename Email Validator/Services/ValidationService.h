//
//  ValidationService.h
//  Email Validator
//
//  Created by Jacob Cho on 4/4/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ValidationResponse.h"

@interface ValidationService : NSObject

+(instancetype)sharedInstance;

-(void)validateEmail:(NSString *)email completion:(void (^)(ValidationResponse *response, NSError *error))completionHandler;

@end
