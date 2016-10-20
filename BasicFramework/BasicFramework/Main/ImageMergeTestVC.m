//
//  ImageMergeTestVC.m
//  BasicFramework
//
//  Created by mr_right on 16/10/19.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "ImageMergeTestVC.h"

@interface ImageMergeTestVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV1;

@property (weak, nonatomic) IBOutlet UIImageView *imgV2;

@property (weak, nonatomic) IBOutlet UIImageView *imgV3;

@property (weak, nonatomic) IBOutlet UIImageView *mergeImgV;

@end

@implementation ImageMergeTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title=@"图片合成";
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"开始合成" style:UIBarButtonItemStylePlain target:self action:@selector(mergeAction:)];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
   
    
    
    
    
    
    
}

-(void)mergeAction:(id)sender{
    
    
    
    NSArray *imgArray = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:@"Unknown1"],
                         [UIImage imageNamed:@"Unknown2"],
                         [UIImage imageNamed:@"Unknown3"],
                         nil];
    
    NSArray *imgPointArray = [[NSArray alloc] initWithObjects:
                              @"10", @"10",
                              @"10", @"25",
                              @"30", @"15",
                              nil];
    
    
    BOOL suc = [self mergedImageOnMainImage:[UIImage imageNamed:@"Unknown1"] WithImageArray:imgArray AndImagePointArray:imgPointArray];
    
    if (suc == YES) {
        NSLog(@"Images Successfully Mearged & Saved to Album");
    }
    else {
        NSLog(@"Images not Mearged & not Saved to Album");
    }
    
    
}

#pragma -mark -functions
//多张图片合成一张
- (BOOL) mergedImageOnMainImage:(UIImage *)mainImg WithImageArray:(NSArray *)imgArray AndImagePointArray:(NSArray *)imgPointArray
{
    
    UIGraphicsBeginImageContext(mainImg.size);
    
    [mainImg drawInRect:CGRectMake(0, 0, mainImg.size.width, mainImg.size.height)];
    int i = 0;
    for (UIImage *img in imgArray) {
        [img drawInRect:CGRectMake([[imgPointArray objectAtIndex:i] floatValue],
                                   [[imgPointArray objectAtIndex:i+1] floatValue],
                                   img.size.width,
                                   img.size.height)];
        
        i+=2;
    }
    
    CGImageRef NewMergeImg = CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage,
                                                          CGRectMake(0, 0, mainImg.size.width, mainImg.size.height));
    
    UIGraphicsEndImageContext();
    if (NewMergeImg == nil) {
        return NO;
    }
    else {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithCGImage:NewMergeImg], self, nil, nil);
        return YES;
    }
    
}


@end
