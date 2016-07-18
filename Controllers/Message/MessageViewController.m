//
//  MessageViewController.m
//  ShoutOut
//
//  Created by Xin Jin on 30/7/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "MessageViewController.h"
#import "MenuNavigationController.h"

#import "MessageCell.h"

#import "OBDragDrop.h"

// --- Defines ---;
// MessageViewController Class;
@interface MessageViewController () <OBOvumSource, OBDropZone>

@end

@implementation MessageViewController

// Functions;
#pragma mark - MessageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Drop Zone Handler;
    btnDelete.dropZoneHandler = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MessageCell";
    MessageCell *cell = [viewMessages dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    OBDragDropManager *dragDropManager = [OBDragDropManager sharedManager];
    UIGestureRecognizer *recognizer = [dragDropManager createLongPressDragDropGestureRecognizerWithSource:self];
    [cell setGestureRecognizer:recognizer];
    
    return cell;
}

#pragma mark - OBOvumSource
- (OBOvum *)createOvumFromView:(UIView *)sourceView
{
    OBOvum *ovum = [[OBOvum alloc] init];
    ovum.dataObject =[NSString stringWithFormat:@"test"];
    
    return ovum;
}

- (UIView *)createDragRepresentationOfSourceView:(UIView *)sourceView inWindow:(UIWindow *)window
{
    CGRect frame = [sourceView convertRect:sourceView.bounds toView:sourceView.window];
    frame = [window convertRect:frame fromWindow:sourceView.window];
    
    viewAvatar.frame = frame;
    
    return viewAvatar;
}

- (void)dragViewWillAppear:(UIView *)dragView inWindow:(UIWindow *)window atLocation:(CGPoint)location
{
    NSLog(@"Will");
}

#pragma mark - OBDropZone
- (OBDropAction)ovumEntered:(OBOvum *)ovum inView:(UIView *)view atLocation:(CGPoint)location
{
    btnDelete.selected = YES;
    return OBDropActionMove;
}

- (OBDropAction)ovumMoved:(OBOvum *)ovum inView:(UIView *)view atLocation:(CGPoint)location
{
    btnDelete.selected = YES;
    return OBDropActionMove;
}

- (void)ovumExited:(OBOvum *)ovum inView:(UIView *)view atLocation:(CGPoint)location
{
    [viewAvatar removeFromSuperview];
    btnDelete.selected = YES;
}

- (void)ovumDropped:(OBOvum *)ovum inView:(UIView *)view atLocation:(CGPoint)location
{
    [viewAvatar removeFromSuperview];
    btnDelete.selected = YES;
}

- (void)handleDropAnimationForOvum:(OBOvum *)ovum withDragView:(UIView *)dragView dragDropManager:(OBDragDropManager *)dragDropManager
{
    btnDelete.selected = NO;
    
    [viewAvatar removeFromSuperview];
}

#pragma mark - Events
- (IBAction)onBtnHome:(id)sender
{
    [self.navigationController performSelector:@selector(toggleMenu) withObject:nil];
}

- (IBAction)onBtnDelete:(id)sender
{
    btnDelete.selected = !btnDelete.selected;
}

@end
