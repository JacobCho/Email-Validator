//
//  SuggestionsAccessoryViewController.h
//  Email Validator
//
//  Created by Jacob Cho on 4/8/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuggestionsAccessoryViewControllerDelegate <NSObject>
-(void)suggestionSelected:(NSString *)suggestion;
@end

@interface SuggestionsAccessoryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) id<SuggestionsAccessoryViewControllerDelegate> delegate;

-(void)filterForUserInput:(NSString *)input;

@end
