//
//  Photo.h
//  Text
//
//  Created by 王正魁 on 14-7-16.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
@interface PhotoImage : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

+(PhotoImage *)sharedPhotoImage;
#pragma mark -压缩图片
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
/**
 image：将要压缩的图片
 newSize：新图片的尺寸
 compressionQuality： 像素压缩比例。
 */
-(NSData*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize compressionQuality:(CGFloat )compressionQuality;

#pragma mark -save image to 沙盒
- (void)saveImage:(UIImage *)tempImage withPath:(NSString *)imagePath;
#pragma mark -remove image to 沙盒
- (void)removeImage:(NSString *)imageName;
@property(nonatomic,copy)void(^blockPhotoEnd)(UIImage* image);



- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
-(UIImage*)screenShots:(UIView*)view;
- (UIImage *)applyBlurRadius:(CGFloat)radius toImage:(UIImage *)image;


@end
//@protocol PhotoDelegate <NSObject>
//
//-(void)photoEnd;
//
//
//@end
