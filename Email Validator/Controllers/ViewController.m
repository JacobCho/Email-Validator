//
//  ViewController.m
//  Email Validator
//
//  Created by Jacob Cho on 4/4/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import "ViewController.h"
#import "ValidationService.h"
#import "ValidationError.h"

@interface ViewController () {
	NSString *didYouMeanSuggestion;
	SuggestionsAccessoryViewController *suggestionsAccessoryViewController;
}

@end

@implementation ViewController

-(void)viewDidLoad {
	[super viewDidLoad];
	[self setupViews];
}

-(void)setupViews {
	self.validateButton.layer.cornerRadius = 5.0;
	self.addButton.layer.cornerRadius = 5.0;
	
	self.textField.delegate = self;
	self.successModal.delegate = self;
	
	[self addTapGesture];
	
	suggestionsAccessoryViewController = [[SuggestionsAccessoryViewController alloc] init];
	suggestionsAccessoryViewController.delegate = self;
	
	[self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	self.textField.inputAccessoryView = suggestionsAccessoryViewController.view;
}

-(void)addTapGesture {
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tapGesture.numberOfTapsRequired = 1;
	[self.view addGestureRecognizer:tapGesture];
}

-(void)showSuccessModal {
	self.overlay.hidden = NO;
	[self.successModal show];
}

#pragma mark - Error Methods
-(void)showError:(ValidationError *)error {
	self.errorLabel.text = error.text;
	self.errorLabel.hidden = NO;
}

-(void)hideErrorLabel {
	self.errorLabel.hidden = YES;
}

#pragma mark - Did You Mean Methods
-(void)hideDidYouMean {
	didYouMeanSuggestion = nil;
	self.didYouMeanLabel.hidden = YES;
	self.addButton.hidden = YES;
}

-(void)showDidYouMean:(NSString *)didYouMean {
	if ([didYouMean isEqual:[NSNull null]]) {
		return;
	}
	didYouMeanSuggestion = didYouMean;
	self.didYouMeanLabel.text = [NSString stringWithFormat:@"Did you mean: %@?", didYouMean];
	self.didYouMeanLabel.hidden = NO;
	self.addButton.hidden = NO;
}

-(void)validateEmail {
	[self hideDidYouMean];
	[self hideErrorLabel];
	NSString *email = self.textField.text;
	
	ValidationError *emailError = [self doesEmailContainError:email];
	if (emailError) {
		[self showError:emailError];
		return;
	}
	
	[self showSpinner];
	ValidationService *service = [ValidationService sharedInstance];
	[service validateEmail:email completion:^(ValidationResponse *response, NSError *error) {
		[self hideSpinner];
		if (response.validationError) {
			[self showError:response.validationError];
			[self showDidYouMean:response.didYouMean];
		} else if (error) {
			[self showError:[ValidationError noConnectionError]];
		} else {
			[self showSuccessModal];
		}
	}];
}

#pragma mark - Helper Methods
-(BOOL)isStringEmpty:(NSString *)string {
	if([string length] == 0) {
		return YES;
	}
	
	if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
		return YES;
	}
	
	return NO;
}

-(BOOL)isValidUser:(NSString *)email {
	if ([email isEqualToString:@""]) {
		return NO;
	}
	NSArray *user = [self getEmailComponents].firstObject;
	NSString *userRegex = @"[A-Z0-9a-z._%+-]+";
	NSPredicate *userTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userRegex];
	return [userTest evaluateWithObject:user];
}

-(BOOL)isValidDomain:(NSString *)email {
	NSArray *components = [self getEmailComponents];
	if (components.count < 2) {
		return NO;
	}
	NSString *domain = components[1];
	NSString *domainRegex = @"[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *domainTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", domainRegex];
	return [domainTest evaluateWithObject:domain];
}

-(ValidationError *)doesEmailContainError:(NSString *)email {
	if ([self isStringEmpty:email]) {
		return [ValidationError emptyStringError];
	} else if (![email containsString:@"@"]) {
		return [ValidationError missingAtCharacterError];
	} else if (![self isValidUser:email]) {
		return [ValidationError invalidUserError];
	} else if (![self isValidDomain:email]) {
		return [ValidationError invalidDomainError];
	}
	
	return nil;
}

-(NSArray *)getEmailComponents {
	NSString *separatorString = @"@";
	NSString *text = self.textField.text;
	return [text componentsSeparatedByString:separatorString];
}

-(void)hideKeyboard {
	[self.textField resignFirstResponder];
}

-(void)showSpinner {
	self.spinnerView.hidden = NO;
}

-(void)hideSpinner {
	self.spinnerView.hidden = YES;
}

#pragma mark - IBActions
-(IBAction)validateButtonPressed:(UIButton *)sender {
	[self validateEmail];
}

- (IBAction)addButtonPressed:(UIButton *)sender {
	self.textField.text = didYouMeanSuggestion;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self hideKeyboard];
	return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
	return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
	if (!self.errorLabel.hidden) {
		[self hideErrorLabel];
	}
}

-(void)textFieldDidChange:(UITextField *)textField {
	NSArray *components = [self getEmailComponents];
	
	// User has entered "@"
	if (components.count > 1) {
		NSString *domain = components[1];
		[suggestionsAccessoryViewController filterForUserInput:domain];
	}
}

#pragma mark - SuccessModalDelegate
-(void)successModalDidDisappear {
	[UIView animateWithDuration:0.5 animations:^{
		self.overlay.alpha = 0.0;
	} completion:^(BOOL finished) {
		self.overlay.hidden = YES;
		
		// Reset overlay
		self.overlay.alpha = 0.6;
	}];
}

#pragma mark - SuggestionsAccessoryViewControllerDelegate
-(void)suggestionSelected:(NSString *)suggestion {
	NSArray *user = [self getEmailComponents].firstObject;
	NSString *fullEmail = [NSString stringWithFormat:@"%@@%@", user, suggestion];
	self.textField.text = fullEmail;
	[self hideKeyboard];
}

@end
