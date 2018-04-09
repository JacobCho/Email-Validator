//
//  SuggestionCollectionViewCell.m
//  Email Validator
//
//  Created by Jacob Cho on 4/8/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import "SuggestionCollectionViewCell.h"

@implementation SuggestionCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
	self.layer.cornerRadius = 5.0;
	self.layer.masksToBounds = YES;
}

@end
