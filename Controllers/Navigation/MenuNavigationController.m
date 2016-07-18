//
//  MenuNavigationController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "MenuNavigationController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "ContactViewController.h"
#import "InviteViewController.h"
#import "SettingViewController.h"

#import "REMenu.h"

// --- Defines ---;
// MenuNavigationController Class;
@interface MenuNavigationController ()

// Properties;
@property (strong, readwrite, nonatomic) REMenu *menu;

@end

@implementation MenuNavigationController

// Functions;
#pragma mark - MenuNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup;
    [self setupMenu];
}

- (void)setupMenu
{
    __typeof (self) __weak weakSelf = self;
    
    // Shouts;
    REMenuItem *homeItem    = [[REMenuItem alloc] initWithTitle:@"Shouts"
                                                          image:[UIImage imageNamed:@"menu_home"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             HomeViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                                                             [weakSelf setViewControllers:@[viewController] animated:NO];
                                                         }];
    homeItem.tag = 1;
    
    // Messages;
    REMenuItem *messageItem = [[REMenuItem alloc] initWithTitle:@"Messages"
                                                          image:[UIImage imageNamed:@"menu_message"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             MessageViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
                                                             [weakSelf setViewControllers:@[viewController] animated:NO];
                                                         }];
    messageItem.tag = 2;
    messageItem.badge = @"12";
    
    // Contacts;
    REMenuItem *contactItem = [[REMenuItem alloc] initWithTitle:@"Contacts"
                                                          image:[UIImage imageNamed:@"menu_contact"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             ContactViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactViewController"];
                                                             [weakSelf setViewControllers:@[viewController] animated:NO];
                                                         }];
    contactItem.tag = 3;
    
    // Invite Friends;
    REMenuItem *inviteItem  = [[REMenuItem alloc] initWithTitle:@"Invite Friends"
                                                          image:[UIImage imageNamed:@"menu_invite"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             InviteViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InviteViewController"];
                                                             [weakSelf setViewControllers:@[viewController] animated:NO];
                                                         }];
    inviteItem.tag = 4;
    
    // Settings;
    REMenuItem *settingItem = [[REMenuItem alloc] initWithTitle:@"Settings"
                                                          image:[UIImage imageNamed:@"menu_setting"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             SettingViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
                                                             [weakSelf setViewControllers:@[viewController] animated:NO];
                                                         }];
    settingItem.tag = 5;
    
    // Log Out;
    REMenuItem *signItem    = [[REMenuItem alloc] initWithTitle:@"Log out"
                                                          image:[UIImage imageNamed:@"menu_logout"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                         }];
    signItem.tag = 6;
    
    // Menu;
    self.menu = [[REMenu alloc] initWithItems:@[homeItem, messageItem, contactItem, inviteItem, settingItem, signItem]];
    
    // Menu;
    if (!REUIKitIsFlatMode()) {
        self.menu.cornerRadius = 4;
        self.menu.shadowRadius = 4;
        self.menu.shadowColor = [UIColor blackColor];
        self.menu.shadowOffset = CGSizeMake(0, 1);
        self.menu.shadowOpacity = 1;
    }
    
    self.menu.separatorOffset = CGSizeMake(8.0f, 0.0f);
    self.menu.imageOffset = CGSizeMake(5, -1);
    self.menu.waitUntilAnimationIsComplete = NO;
    self.menu.badgeLabelConfigurationBlock = ^(UILabel *badgeLabel, REMenuItem *item) {
        badgeLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:60.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
//      badgeLabel.backgroundColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
        badgeLabel.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:60.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor;
    };
    
    [self.menu setClosePreparationBlock:^{
        NSLog(@"Menu will close");
    }];
    
    [self.menu setCloseCompletionHandler:^{
        NSLog(@"Menu did close");
    }];
}

- (void)toggleMenu
{
    if (self.menu.isOpen) {
        return [self.menu close];
    }
    
    [self.menu showFromNavigationController:self];
}

@end
