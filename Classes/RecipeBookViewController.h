//
//  RecipeBookViewController.h
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20+Additions.h>
#import <QuartzCore/QuartzCore.h>

@interface RecipeBookViewController : TTTableViewController {

}

-(id)initWithRecipes:(NSString *)placeholder query:(NSDictionary*)query;

@end
