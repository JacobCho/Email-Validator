//
//  ViewController.h
//  Email Validator
//
//  Created by Jacob Cho on 4/4/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuccessModal.h"
#import "SuggestionsAccessoryViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate, SuccessModalDelegate, SuggestionsAccessoryViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIButton *validateButton;
@property (weak, nonatomic) IBOutlet UILabel *didYouMeanLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIView *overlay;
@property (weak, nonatomic) IBOutlet SuccessModal *successModal;
@property (weak, nonatomic) IBOutlet UIView *spinnerView;

- (IBAction)validateButtonPressed:(UIButton *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;

@end

