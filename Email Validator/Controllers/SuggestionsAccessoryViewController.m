//
//  SuggestionsAccessoryViewController.m
//  Email Validator
//
//  Created by Jacob Cho on 4/8/18.
//  Copyright © 2018 Jacob Cho. All rights reserved.
//

#import "SuggestionsAccessoryViewController.h"
#import "SuggestionCollectionViewCell.h"

@interface SuggestionsAccessoryViewController () {
	NSArray *domains;
	NSArray *filteredArray;
}
@end

@implementation SuggestionsAccessoryViewController

-(void)viewDidLoad {
	[super viewDidLoad];
	[self buildDomainsArray];
	[self.collectionView registerNib:[UINib nibWithNibName:@"SuggestionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SuggestionCollectionViewCell"];
}

-(void)buildDomainsArray {
	// Credit to https://github.com/mailcheck/mailcheck/wiki/List-of-Popular-Domains
	
	domains = @[
						 /* Default domains included */
						 @"aol.com", @"att.net", @"comcast.net", @"facebook.com", @"gmail.com", @"gmx.com", @"googlemail.com",
						 @"google.com", @"hotmail.com", @"hotmail.co.uk", @"mac.com", @"me.com", @"mail.com", @"msn.com",
						 @"live.com", @"sbcglobal.net", @"verizon.net", @"yahoo.com", @"yahoo.co.uk",
						 
						 /* Other global domains */
						 @"email.com", @"fastmail.fm", @"games.com" /* AOL */, @"gmx.net", @"hush.com", @"hushmail.com", @"icloud.com",
						 @"iname.com", @"inbox.com", @"lavabit.com", @"love.com" /* AOL */, @"outlook.com", @"pobox.com", @"protonmail.com",
						 @"rocketmail.com" /* Yahoo */, @"safe-mail.net", @"wow.com" /* AOL */, @"ygm.com" /* AOL */,
						 @"ymail.com" /* Yahoo */, @"zoho.com", @"yandex.com",
						 
						 /* United States ISP domains */
						 @"bellsouth.net", @"charter.net", @"cox.net", @"earthlink.net", @"juno.com",
						 
						 /* British ISP domains */
						 @"btinternet.com", @"virginmedia.com", @"blueyonder.co.uk", @"freeserve.co.uk", @"live.co.uk",
						 @"ntlworld.com", @"o2.co.uk", @"orange.net", @"sky.com", @"talktalk.co.uk", @"tiscali.co.uk",
						 @"virgin.net", @"wanadoo.co.uk", @"bt.com", @"gmail.co.uk",
						 
						 /* Domains used in Asia */
						 @"sina.com", @"qq.com", @"naver.com", @"hanmail.net", @"daum.net", @"nate.com", @"yahoo.co.jp", @"yahoo.co.kr", @"yahoo.co.id", @"yahoo.co.in", @"yahoo.com.sg", @"yahoo.com.ph",
						 
						 /* French ISP domains */
						 @"hotmail.fr", @"live.fr", @"laposte.net", @"yahoo.fr", @"wanadoo.fr", @"orange.fr", @"gmx.fr", @"sfr.fr", @"neuf.fr", @"free.fr",
						 
						 /* German ISP domains */
						 @"gmx.de", @"hotmail.de", @"live.de", @"online.de", @"t-online.de" /* T-Mobile */, @"web.de", @"yahoo.de",
						 
						 /* Italian ISP domains */
						 @"libero.it", @"virgilio.it", @"hotmail.it", @"aol.it", @"tiscali.it", @"alice.it", @"live.it", @"yahoo.it", @"email.it", @"tin.it", @"poste.it", @"teletu.it",
						 
						 /* Russian ISP domains */
						 @"mail.ru", @"rambler.ru", @"yandex.ru", @"ya.ru", @"list.ru",
						 
						 /* Belgian ISP domains */
						 @"hotmail.be", @"live.be", @"skynet.be", @"voo.be", @"tvcablenet.be", @"telenet.be",
						 
						 /* Argentinian ISP domains */
						 @"hotmail.com.ar", @"live.com.ar", @"yahoo.com.ar", @"fibertel.com.ar", @"speedy.com.ar", @"arnet.com.ar",
						 
						 /* Domains used in Mexico */
						 @"yahoo.com.mx", @"live.com.mx", @"hotmail.es", @"hotmail.com.mx", @"prodigy.net.mx",
						 
						 /* Domains used in Brazil */
						 @"yahoo.com.br", @"hotmail.com.br", @"outlook.com.br", @"uol.com.br", @"bol.com.br", @"terra.com.br", @"ig.com.br", @"itelefonica.com.br", @"r7.com", @"zipmail.com.br", @"globo.com", @"globomail.com", @"oi.com.br"
						 ];
}

-(void)filterForUserInput:(NSString *)input {
	if ([input isEqualToString:@""]) {
		return;
	}
	NSString *filter = @"SELF BEGINSWITH[cd] %@";
	NSPredicate *predicate = [NSPredicate predicateWithFormat:filter, input];
	filteredArray = [domains filteredArrayUsingPredicate:predicate];
	[self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return filteredArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	SuggestionCollectionViewCell *cell = (SuggestionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SuggestionCollectionViewCell" forIndexPath:indexPath];
	NSString *suggestion = filteredArray[indexPath.row];
	cell.label.text = suggestion;
	return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSString *suggestion = filteredArray[indexPath.row];
	[self.delegate suggestionSelected:suggestion];
}

@end
