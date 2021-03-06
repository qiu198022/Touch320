//
//  RadioDataSource.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioDataSource.h"
#import "RadioTableItem.h"
#import "RadioTableItemCell.h"
#import "BannerImageTableCell.h"
#import "BannerImageTableItem.h"

@implementation RadioDataSource

- (id)initWithModel {
	if( [self init] ) {
		_radioModel = [[RadioModel alloc] init];
	}
	
	NSLog(@"init radio data source");
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_radioModel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _radioModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	//NSLog(@"Radio Items: %@", _radioModel.radioItems);
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSArray *keys = [_radioModel.radioItems allKeys];
	
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[items addObject:[BannerImageTableItem
						  itemWithBannerImage:[UIImage imageNamed:@"radio-banner"]]];
	}
	else {
		[items addObject:[BannerImageTableItem
						  itemWithBannerImage:[UIImage imageNamed:@"radio-banner-iPad"]]];
	}
	
	for (id key in sortedKeys) {
		NSMutableDictionary* theItem = [_radioModel.radioItems objectForKey:key];
		
		NSString* title = [theItem objectForKey:@"title"];
		NSString* author = [theItem objectForKey:@"itunes:author"];
		NSString* subtitle = [theItem objectForKey:@"itunes:subtitle"];
		NSString* summary = [theItem objectForKey:@"itunes:summary"];
		NSString* pubDate = [theItem objectForKey:@"pubDate"];
		NSString* link = [theItem objectForKey:@"guid"];
		NSString* episode_duration = [theItem objectForKey:@"itunes:duration"];
		NSString* title_label = [theItem objectForKey:@"itunes:subtitle"];
		NSString* subtitle_label = [theItem objectForKey:@"title"];
		
		if( !TTIsSetWithItems(title) ) {
			[items addObject:[RadioTableItem
							  itemWithText: title
							  title: title
							  author: author
							  subtitle: subtitle
							  summary: summary
							  pubDate: pubDate
							  link: link
							  episode_duration: episode_duration
							  title_label: title_label
							  subtitle_label: subtitle_label]];
		}
	} 
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource 

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object { 
	if ([object isKindOfClass:[RadioTableItem class]]) { 
		return [RadioTableItemCell class]; 
	} 
	else if ([object isKindOfClass:[BannerImageTableItem class]]) { 
		return [BannerImageTableCell class]; 
	}
	else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
} 

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath { 
	cell.accessoryType = UITableViewCellAccessoryNone;
} 

@end
