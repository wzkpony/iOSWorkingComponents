//
//  NSObject+IFSystem.m
//  IronFish
//
//  Created by wzk on 2018/12/25.
//  Copyright © 2018 wzk. All rights reserved.
//

#import "NSObject+IFSystem.h"

@implementation NSObject (IFSystem)
#pragma mark - 使用系统邮件客户端发送邮件
/**
 recipients:收件人
 subject :主题
 messageBody :内容
 */
+ (MFMailComposeViewController *)launchMailAppDelegateRecipients:(NSArray<NSString *> *)recipients subject:(NSString *)subject messageBody:(NSString *)messageBody delegate:(id<MFMailComposeViewControllerDelegate>)obj
{
    MFMailComposeViewController *picker = nil;
    if([MFMailComposeViewController canSendMail]) {// 判断设备是否支持发送邮件
        // 创建对象
        picker = [[MFMailComposeViewController alloc]init];
        // 设置代理
        picker.mailComposeDelegate = obj;
        picker.navigationBar.tintColor= [UIColor blackColor];
        // 设置收件人
        [picker setToRecipients:recipients];
        // 设置主题
        [picker setSubject:subject];
        // 设置邮件内容
        [picker setMessageBody:messageBody isHTML:NO];
       
    }
   
  
    return picker;
}


- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *temp in windows) {
            if (temp.windowLevel == UIWindowLevelNormal) {
                window = temp;
                break;
            }
        }
    }
    
    result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    
    //第二层的tabbarVc
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    
    
    return result;
}

///限制字符长度
- (void)textFieldDidChange:(UITextField *)textField interger:(NSUInteger)integer {
    NSString *text = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position){
        if (text.length > integer){
            NSRange range;
            NSUInteger inputLength = 0;
            for(int i=0; i < text.length && inputLength <= integer; i += range.length) {
                range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
                inputLength += [text substringWithRange:range].length;
                if (inputLength > integer) {
                    NSString* newText = [text substringWithRange:NSMakeRange(0, range.location)];
                    textField.text = newText;
                }
            }
        }
    }
}

/**

#pragma  mark -- 选择照片 照片的逻辑开始 --
- (void)showAlertViewForPic {
    WeakSelf;
    [LEEAlert actionsheet].config
    .LeeCornerRadius(5)
    .LeeAddAction(^(LEEAction *action) {
        // 自定义设置Block
        // 关于更多属性的设置 请查看'LEEAction'类 这里不过多演示了
        action.title = @"拍照";
        action.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        action.titleColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1/1.0];
        action.clickBlock = ^{
            NSLog(@"拍照");
            [self photoPic];
        };
    })
    .LeeAddAction(^(LEEAction *action) {
        // 自定义设置Block
        // 关于更多属性的设置 请查看'LEEAction'类 这里不过多演示了
        action.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        action.title = @"手机相册";
        action.backgroundImage = [UIImage imageNamed:@"Rectangle27"];
        action.titleColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1/1.0];
        action.clickBlock = ^{
            NSLog(@"手机相册");
            [weakSelf imagePickerVC];
        };
    })
    .LeeShow();
}


///拍照
- (void)photoPic{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
//    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        [MBProgressHUD ll_showTipMessageInWindow:@"没有摄像头"];
    }
    
}

///拍照回调
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    WeakSelf;
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image meta:meta location:NULL completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                [weakSelf performSelectorOnMainThread:@selector(addImage:) withObject:image waitUntilDone:true];
                [picker dismissViewControllerAnimated:YES completion:^{
                }];
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:NULL completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
//                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                            [weakSelf addImage:photo];

                        }
                    }];
                }
            }];
        }
    }
}


///照片选择成功（相机或者相册）
-(void)addImage:(UIImage*)image{
//    self.imageView.image = image;
}

///图片压缩
- (NSData *)configImageData:(UIImage *)image{
   UIGraphicsBeginImageContext(CGSizeMake(image.size.width/2.0, image.size.height/2.0));
   [image drawInRect:CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
   UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   NSData *data = UIImageJPEGRepresentation(resultImage, 0.3);
   return data;
}

///上传图片
- (void)requestUpdateFiled:(NSArray *)fileArray nameKeys:(NSArray *)nameKeys mimeTypes:(NSArray *)mimeTypes{
    __weak typeof(self) weakSelf = self;
    [RequestUtil requestPostForFiles:upload_head para:@{} fileArray:fileArray nameKeys:nameKeys mimeTypes:mimeTypes completionBlock:^(NSInteger statusCode, id errorString, id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            NSDictionary *dict = responseObject[@"data"];;
//            weakSelf.headerImageUrl = dict[@"user_avatarurl"];
//            [weakSelf.tableView reloadData];
        }
        else {
            [MBProgressHUD ll_showTipMessageInWindow:responseObject[@"msg"]];
        }
    }];
}


///从相册选择
- (void)imagePickerVC {
    __weak typeof(self) weakSelf = self;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    // 是否允许显示视频
    imagePickerVc.allowPickingVideo =  NO;
    // 是否允许显示图片
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.allowTakePicture = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    
//        for (NSInteger i = 0; i<photos.count; i++) {
            UIImage* img = photos[0];
            [weakSelf performSelectorOnMainThread:@selector(addImage:) withObject:img waitUntilDone:true];
//        }
        
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationOverFullScreen;

//    [self.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma  mark -- 关于照片的逻辑到此 --

*/

@end
