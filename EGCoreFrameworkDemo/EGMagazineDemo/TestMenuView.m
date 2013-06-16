//
//  TestMenuView.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-6-11.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "TestMenuView.h"
#import "EGCore/Constant.h"
#import "EGCore/EGCoreAnimation.h"

@implementation TestMenuView
@synthesize  background, selectedItem;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [Constant addImageView:CGRectMake(0,-640,129,41) withImageName:@"720_quanjing" inView:self];
        
        isShow = FALSE;
        UIButton *head = [Constant addButton:CGRectMake(0, 0, 128, 110) withImage:@"" inView:self];
        [head addTarget:self action:@selector(showAndHide) forControlEvents:UIControlEventTouchUpInside];
        
        background = [Constant addImageView:self.bounds withImageName:@"menu_show" inView:self];
        for( int i=0; i<10; i++ ){
            CGRect frame = CGRectMake(0, 110+i*35, 128, 35);
            NSString *name = [ NSString stringWithFormat:@"menu_%d", (i+1)];
            NSString *name_select = [ NSString stringWithFormat:@"menu_%d_press", (i+1)];
            NSArray *imageList = [NSArray arrayWithObjects:name, name, name_select, nil];
            UIButton *button = [Constant addButton:frame withImageList:(NSArray*)imageList inView:self];
            button.tag = 100+i;
            [button addTarget:self action:@selector(touchItem:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self touchItem:[self viewWithTag:100]];
    }
    return self;
}


-(void)showAndHide
{
    if(!isShow){
        [EGCoreAnimation moveY:self.frame.origin.y-346 duration:0.3 delay:0 inView:self];
    } else {
        [EGCoreAnimation moveY:self.frame.origin.y+346 duration:0.3 delay:0 inView:self];
    }
    isShow = !isShow;
}



-(void) touchItem:(id)sender
{
    if( currentTag != [sender tag] ){
        if(currentTag != 0){
            UIButton *current = (UIButton *)[self viewWithTag: currentTag];
            NSString *name = [NSString stringWithFormat:@"menu_%d", (currentTag-100+1)];
            [current setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        }
        NSString *name = [NSString stringWithFormat:@"menu_%d_press", [sender tag]-100+1];
        [sender setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        currentTag = [sender tag];
    }
}

@end
