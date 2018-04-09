//
//  SuccessModal.m
//  Email Validator
//
//  Created by Jacob Cho on 4/7/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import "SuccessModal.h"

@implementation SuccessModal

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self customInit];
	}
	
	return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self customInit];
	}
	
	return self;
}

-(void)customInit {
	[[NSBundle mainBundle] loadNibNamed:@"SuccessModal" owner:self options:nil];
	
	[self addSubview:self.contentView];
	
	self.contentView.frame = self.bounds;
	self.layer.cornerRadius = 10.0;
	self.layer.masksToBounds = YES;
}

-(void)show {
	self.transform = CGAffineTransformMakeScale(0.1, 0.1);
	self.hidden = NO;
	
	[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:3.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.transform = CGAffineTransformMakeScale(1.0, 1.0);
	} completion:^(BOOL finished) {
		[self disappear];
	}];
}

-(void)disappear {
	[NSTimer scheduledTimerWithTimeInterval:2.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
		[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			[self.delegate successModalDidDisappear];
			self.transform = CGAffineTransformMakeScale(0.1, 0.1);
		} completion:^(BOOL finished) {
			self.hidden = YES;
		}];
	}];
}



@end
