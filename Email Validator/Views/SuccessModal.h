//
//  SuccessModal.h
//  Email Validator
//
//  Created by Jacob Cho on 4/7/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuccessModalDelegate <NSObject>
-(void)successModalDidDisappear;

@end

@interface SuccessModal : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) id<SuccessModalDelegate> delegate;

-(void)show;

@end
