//
//  HSImgConfigVC.m
//  HSiOS
//
//  Created by wzk on 2021/10/16.
//

#import "HSImgConfigVC.h"
#import "HSDrawMaskView.h"
#import <Photos/Photos.h>

@interface HSImgConfigVC ()<UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *_gesTapTwo;
    UIRotationGestureRecognizer *_gesRotation;
    UIPinchGestureRecognizer *_gesPinch;
    UIPanGestureRecognizer *_gesPan;
    
    BOOL _hadGesEndPan;
    BOOL _hadGesEndPinch;
    BOOL _hadGesEndRotation;
    
    BOOL _animating;
    
    CGFloat _scale;
    //_theScale记录最终的Scale
    CGFloat _theScale;
    CGFloat _rotation;
    //_theRotation记录最终的Rotation
    CGFloat _theRotation;
    CGFloat _pointX;
    //_thePointX记录最终的PointX
    CGFloat _thePointX;
    CGFloat _pointY;
    //_thePointY记录最终的PointY
    CGFloat _thePointY;
    
    BOOL _touchBegin;
    BOOL _hadAfterReset;
}

@property (weak, nonatomic) IBOutlet UIButton *changeImgButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewH;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,assign)CGFloat minScale;      //最小绽放比例,默认0.3

@property(nonatomic,assign)CGFloat maxScale;      //最大绽放比例,默认5.0
@property(nonatomic,assign)BOOL enableTapTwo;       //是否允许双击,默认YES

@property(nonatomic,assign)BOOL enableRotation;     //是否允许旋转,默认YES

@property(nonatomic,assign)BOOL enablePinch;        //是否允许绽放,默认YES

@property(nonatomic,assign)BOOL enablePan;          //是否允许平移,默认YES

@property (weak, nonatomic) IBOutlet UIButton *beforeImgButton;

@property (strong ,nonatomic) HSDrawMaskView *drawMaskView;
@property (weak, nonatomic) IBOutlet UIButton *nextImgButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (assign ,nonatomic) NSInteger  currentPageImage;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@property (strong ,nonatomic) NSMutableArray<NSMutableDictionary *> *resultImgArray;



@property (strong ,nonatomic) IBOutlet UIImageView *templateImageView;
@end

@implementation HSImgConfigVC
-(void)initializeVariable{
    
    _enableTapTwo=YES;
    _enableRotation=YES;
    _enablePinch=YES;
    _enablePan=YES;
    _minScale=0.3;
    _maxScale=5.0;
    
    [self initializeTouch];
    
    _animating=NO;
    
    _hadGesEndPan=YES;
    _hadGesEndPinch=YES;
    _hadGesEndRotation=YES;
    
    _touchBegin=NO;
    _hadAfterReset=NO;
}
-(void)initializeTouch{
    _scale=1.0;
    _theScale=1.0;
    
    _rotation=0.0;
    _theRotation=0.0;
    
    _pointX=0;
    _thePointX=0;
    
    _pointY=0;
    _thePointY=0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ///边缘测滑手势返回。
    
    if (self.dataSource.count <= 0) {
        self.beforeImgButton.hidden = YES;
        self.nextImgButton.hidden = YES;
        self.okButton.hidden = NO;
        self.cancelButton.hidden = NO;
        self.imageView.image = self.image;
        self.pageLabel.hidden = YES;
    }
    else {

        /**
         {
             currentPage = 0;
             height = 694;
             id = 56293;
             image = "https://pic.yusivip.com/ddc46ce2f0995d4c1fd8f21576092f18.png";
             "image_count" = 1;
             imgAsset = "<PHAsset: 0x11d40c0a0> 77222E47-424F-4262-BEE5-AFBB5DEF9614/L0/001 mediaType=1/0, sourceType=1, (887x1920), creationDate=2021-05-11 05:50:45 +0000, location=0, hidden=0, favorite=0, adjusted=0 ";
             isSelected = 1;
             rowIndex = 0;
             status = 1;
             tagNumber = 1;
             "template_page_id" = 975;
             "user_mb_id" = 186;
             "user_page_id" = 37634;
             width = 654;
         }
         */
        self.beforeImgButton.hidden = NO;
        self.nextImgButton.hidden = NO;
        self.okButton.hidden = YES;
        self.cancelButton.hidden = YES;
        self.pageLabel.hidden = NO;
    }
    
    self.imageView.userInteractionEnabled = YES;
    self.imageView.multipleTouchEnabled = YES;
    
    self.bottomViewH.constant = 110;
    self.imageView.frame = CGRectMake(0, + 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.bottomViewH.constant);


    [self initializeVariable];
    
    //点击手势
    _gesTapTwo=[[UITapGestureRecognizer alloc] init];
    [_gesTapTwo addTarget:self action:@selector(gesBeTouchInPhotoShowView:)];
    _gesTapTwo.numberOfTapsRequired=2;
    _gesTapTwo.delegate=self;
    [self.imageView addGestureRecognizer:_gesTapTwo];
    
    //旋转手势
    _gesRotation=[[UIRotationGestureRecognizer alloc] init];
    [_gesRotation addTarget:self action:@selector(gesBeTouchInPhotoShowView:)];
    _gesRotation.delegate=self;
    [self.imageView addGestureRecognizer:_gesRotation];

    //图片放大缩小手势
    _gesPinch=[[UIPinchGestureRecognizer alloc] init];
    [_gesPinch addTarget:self action:@selector(gesBeTouchInPhotoShowView:)];
    _gesPinch.delegate=self;
    [self.imageView addGestureRecognizer:_gesPinch];

    //拖拽手势
    _gesPan=[[UIPanGestureRecognizer alloc] init];
    [_gesPan addTarget:self action:@selector(gesBeTouchInPhotoShowView:)];
    _gesPan.delegate=self;
    _gesPan.minimumNumberOfTouches=1;
    [self.imageView addGestureRecognizer:_gesPan];

    
    if (self.dataSource.count <= 0) {
        [self configImageFrame];
    }
    else {
        [self selectBeforeButton:nil];
    }
    
//    [self.changeImgButton configCornerRadius:self.changeImgButton.jk_height/2.0 borderWidth:1 borderColor:[UIColor whiteColor]];

    if (self.dataSource.count == 1) {
        [self.nextImgButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    


    
    
}

- (void)configVideoImage:(NSDictionary *)dict complat:(void (^)(void))resultHandler {
    CGFloat width = [dict[@"width"] floatValue];
    CGFloat height = [dict[@"height"] floatValue];
    self.drowFrame = [self configDrawFrameWidth:width/[UIScreen mainScreen].scale height:height/[UIScreen mainScreen].scale];
    
    PHAsset *asset = dict[@"imgAsset"];
    CGSize size =  CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = NO;
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeNone;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
//    __block UIImage *img = nil;
//    WeakSelf;
//    [MBProgressHUD ll_showActivity];
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result != nil) {
//            [MBProgressHUD ll_dismiss];
//            weakSelf.imageView.image = result;
            resultHandler();
        }
        else {
            NSLog(@"图片获取失败 info = %@",info);
        }
//        else if () {
            
//        }
    }];

}

///添加或重制裁剪框
- (void)configDrawMaskView {
    
    [self.view addSubview:self.drawMaskView];
    [self.view bringSubviewToFront:self.templateImageView];
    CGRect rect = CGRectMake(100, 100, 200, 300);
    if (self.drowFrame.size.height > 0 && self.drowFrame.size.width > 0) {
        rect = self.drowFrame;
    }
    self.drawMaskView.fillLayerFrame = rect;
//    [self.drawMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
////        make.top.bottom.left.right.equalTo(self.imageView);
//        make.top.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(self.bottomViewH.constant);
//    }];
    
    NSDictionary *dict = self.dataSource[self.currentPageImage];
    NSString *templatePageID = [NSString stringWithFormat:@"%@",dict[@"template_page_id"]];
    __block NSString *imageUrlStr = nil;
    [self.templateArrData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        HSVideoInviteCardContentEditModelTemplate *templateData = (HSVideoInviteCardContentEditModelTemplate *)obj;
//        if ([templateData.ID isEqualToString:templatePageID]) {
//            imageUrlStr = templateData.cover_image;
//            *stop = YES;
//        }
    }];
//    [self.templateImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:nil];
}

///图片大小自适应
- (void)configImageFrame {
    CGFloat se = self.imageView.image.size.width/self.imageView.image.size.height;
    CGFloat imageW = 0;
    CGFloat imageH = 0;
    
    if (self.drowFrame.size.width < self.drowFrame.size.height) {
        imageH = self.drowFrame.size.height;
        imageW = imageH * se;
        if (imageW < self.drowFrame.size.width) {
            imageW = self.drowFrame.size.width;
            imageH = imageW / se;
        }
        
    }
    else {
        imageW = self.drowFrame.size.width;
        imageH = imageW / se;
    }
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.frame = CGRectMake(0, self.drowFrame.origin.y, imageW, imageH);
    CGPoint point = self.imageView.center;
    point.x = App_WIDTH/2.0;
    self.imageView.center = point;
}
    
///裁剪框大小设置
- (CGRect)configDrawFrameWidth:(CGFloat)width height:(CGFloat)height {
    if (self.dataSource.count > 0) {
        CGFloat w = width;
//        CGFloat scale = width / height;
        CGFloat h = height;
//        CGFloat h = w / scale;
//        //屏幕宽度 - 导航栏高度 - 底部安全区域 - 底部View的高度 - 20间隔 - 裁剪的y坐标。
//        CGFloat drawH = App_HEIGHT - App_NavHeight - App_BottomHeight - 110 - 20 - 80;
//        if (h >= drawH) {
//            //如果高度大于屏幕显示外了，高度固定，宽度成比例。
//            h = drawH;
//            w = drawH * scale;
//        }
        
        CGFloat x = App_WIDTH/2.0 - w/2.0;
        CGFloat y = 80+App_NavHeight;
        return CGRectMake(x, y, w, h);

    }
    else {
        //以固定宽度，高度成比例
        CGFloat w = 320.0*App_SCREEN_RATIO6;
        CGFloat scale = width / height;
        CGFloat h = w / scale;
        //屏幕宽度 - 导航栏高度 - 底部安全区域 - 底部View的高度 - 20间隔 - 裁剪的y坐标。
        CGFloat drawH = App_HEIGHT - App_NavHeight - App_BottomHeight - 110 - 20 - 80;
        if (self.nav_View.jk_height > 0) {
            drawH = App_HEIGHT - App_BottomHeight - 110 - 20 - 80;
        }
        if (h >= drawH) {
            //如果高度大于屏幕显示外了，高度固定，宽度成比例。
            h = drawH;
            w = drawH * scale;
        }
        
        CGFloat x = App_WIDTH/2.0 - w/2.0;
        CGFloat y = 80+App_NavHeight;
        return CGRectMake(x, y, w, h);
    }
    
}

#pragma mark - 手势
-(void)gesBeTouchInPhotoShowView:(UIGestureRecognizer*)ges{
    if (ges==_gesTapTwo) {
        if (_enableTapTwo) {
            if (_gesTapTwo.state==UIGestureRecognizerStateEnded) {
                if (_theScale==1.0) {
                    _theScale=1.0;
                    _scale=1.0;
                }else{
                    _theScale=1.0;
                    _scale=1.0;
                }
                [self transformToZero:YES];
            }
        }
    }
    if(ges==_gesRotation){
        if (_enableRotation) {
            _hadGesEndRotation=NO;
            _rotation=_gesRotation.rotation;
            [self updateImageTransformWithAnimate:NO withGesture:ges offsetX:0 offsetY:0];
            if (_gesRotation.state==UIGestureRecognizerStateEnded) {
                _theRotation+=_rotation;
                _rotation=0.0;
                _hadGesEndRotation=YES;
            }
        }
    }
    if(ges==_gesPinch){
        if (_enablePinch) {
            _hadGesEndPinch=NO;
            _scale=_gesPinch.scale;
            [self updateImageTransformWithAnimate:NO withGesture:ges offsetX:0 offsetY:0];
            if (_gesPinch.state==UIGestureRecognizerStateEnded) {
                _theScale*=_scale;
                _scale=1.0;
                _hadGesEndPinch=YES;
            }
        }
    }
    if(ges==_gesPan){
        if (_enablePan) {
            _hadGesEndPan=NO;
            CGPoint point=[_gesPan translationInView:self.imageView];
//            NSLog(@"%@",NSStringFromCGPoint(point));
//            _pointX=point.x/((_theScale<1)?1:_theScale);
//            _pointY=point.y/((_theScale<1)?1:_theScale);
            _pointX=point.x;
            _pointY=point.y;
            [self updateImageTransformWithAnimate:NO withGesture:ges offsetX:0 offsetY:0];
            if (_gesPan.state==UIGestureRecognizerStateEnded) {
                _thePointX+=_pointX;
                _thePointY+=_pointY;
                _pointX=0.0;
                _pointY=0.0;
                _hadGesEndPan=YES;
            }
        }
    }
    if (_gesPan.state==UIGestureRecognizerStateChanged||
        _gesPinch.state==UIGestureRecognizerStateChanged||
        _gesRotation.state==UIGestureRecognizerStateChanged) {
        
        if (!_touchBegin) {
            _touchBegin=YES;
//            [self delegatePhotoShowViewTouchBegan:self];
        }
        
    }else{
        if (_touchBegin) {
            _touchBegin=NO;
            NSLog(@"%@",NSStringFromCGRect(self.imageView.frame));
//            CGFloat ofsetX =  self.drowFrame.origin.x - self.imageView.frame.origin.x;
//            CGFloat ofsetY =  self.drowFrame.origin.y - self.imageView.frame.origin.y;
//            [self updateImageTransformWithAnimate:YES withGesture:ges offsetX:ofsetX offsetY:ofsetY];
//            if (ofsetX < 0) {
//                _thePointX = _thePointX+ofsetX;
//            }
//            else {
//                _thePointX+=_pointX;
//            }
//            if (ofsetY < 0) {
//                _thePointY = _thePointY+ofsetY;
//            }
//            else {
//                _thePointY+=_pointY;
//            }
            
        }
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
#pragma mark - 图片形变
//-(void)imageTransformWithAnimate:(BOOL)ani withGesture:(UIGestureRecognizer *)ges {
//    _animating=YES;
//    CGFloat newScale=_scale*_theScale;
//    if (newScale>=_maxScale) {
//        newScale=_maxScale;
//        _scale=1.0;
//        _theScale=_maxScale;
//    }
//    if (newScale<=_minScale) {
//        newScale=_minScale;
//        _scale=1.0;
//        _theScale=_minScale;
//    }
//    CGAffineTransform t=CGAffineTransformMakeScale(newScale, newScale);
//    t=CGAffineTransformRotate(t, _rotation+_theRotation);
//    t=CGAffineTransformTranslate(t, _pointX+_thePointX, _pointY+_thePointY);
//    if (ani) {
//        [UIView animateWithDuration:0.26 animations:^{
//            self->_imageView.transform=t;
//        }];
//    }else{
//        _imageView.transform=t;
//    }
//}

-(void)updateImageTransformWithAnimate:(BOOL)ani withGesture:(UIGestureRecognizer *)ges offsetX:(CGFloat)x offsetY:(CGFloat)y {
    _animating=YES;
    CGFloat newScale=_scale*_theScale;
    if (newScale>=_maxScale) {
        newScale=_maxScale;
        _scale=1.0;
        _theScale=_maxScale;
    }
    if (newScale<=_minScale) {
        newScale=_minScale;
        _scale=1.0;
        _theScale=_minScale;
    }
    CGAffineTransform t=CGAffineTransformMakeScale(newScale, newScale);
    t=CGAffineTransformRotate(t, _rotation+_theRotation);
//    if (ges==_gesPan){
//        t=CGAffineTransformTranslate(t, _pointX+_thePointX+x, _pointY+_thePointY+y);
//    }
//    else {
//        t=CGAffineTransformTranslate(t, x, y);
//    }
    t=CGAffineTransformTranslate(t, _pointX+_thePointX, _pointY+_thePointY);

    if (ani) {
        [UIView animateWithDuration:0.26 animations:^{
            self->_imageView.transform=t;
        }];
    }else{
        _imageView.transform=t;
    }
}

///还原
-(void)transformToZero:(BOOL)animation{
    [self initializeTouch];
    [self updateImageTransformWithAnimate:animation withGesture:nil offsetX:0 offsetY:0];
    _animating=NO;
//    [self setNeedsLayout];
//    [self delegatePhotoShowViewPhotoReduction:self];
}

#pragma  mark -- button Action
- (IBAction)selectOKButton:(id)sender {
    UIImage *resImg = [self imageScreenShot];
    if (resImg) {
        if (self.selectOKButtonBlock) {
            self.selectOKButtonBlock(self,resImg);
        }
//        [MBProgressHUD ll_showTipMessageInWindow:@"截图成功，相册可以查看"];
    }
}

- (IBAction)selectCancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectChangeImageButton:(id)sender {
    [self showAlertViewForPic];
}

- (IBAction)selectBeforeButton:(id)sender {
    self.currentPageImage--;
    if (self.currentPageImage <= 0) {
        self.currentPageImage = 0;
        self.beforeImgButton.hidden = YES;
    }
    if (self.currentPageImage > 0) {
        [self transformToZero:NO];
    }
    
    NSDictionary *dict = self.dataSource[self.currentPageImage];
    WeakSelf;
    [self configVideoImage:dict complat:^{
        [weakSelf configDrawMaskView];
        [weakSelf configImageFrame];
    }];
   
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentPageImage+1,self.dataSource.count];
    [self.nextImgButton setTitle:@"下一张" forState:UIControlStateNormal];

}

- (IBAction)selectNextButton:(id)sender {
    self.beforeImgButton.hidden = NO;
    //做裁剪
    UIImage *resImg = [self imageScreenShot];
    if (resImg == nil) {
        NSAssert(NO, @"没有图片呀");
    }
    NSDictionary *dictItem = self.dataSource[self.currentPageImage];
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] initWithDictionary:dictItem];
    [resultDict setValue:resImg forKey:@"imageData"];
    [self.resultImgArray addObject:resultDict];
    
    if ([self.nextImgButton.currentTitle isEqualToString:@"完成"]) {
        if (self.selectDataSourceOKButtonBlock) {
            self.selectDataSourceOKButtonBlock(self, self.resultImgArray);
        }
        return;
    }
    
    self.currentPageImage++;
    if (self.currentPageImage >= self.dataSource.count-1) {
        self.currentPageImage = self.dataSource.count-1;
    }
    [self transformToZero:NO];
    
    NSDictionary *dict = self.dataSource[self.currentPageImage];
    WeakSelf;
    [self configVideoImage:dict complat:^{
        [weakSelf configDrawMaskView];
        [weakSelf configImageFrame];
    }];
    
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentPageImage+1,self.dataSource.count];
    if ((self.currentPageImage+1) == self.dataSource.count) {
        [self.nextImgButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    
    
}

#pragma  mark -- 截屏
- (UIImage *)imageScreenShot {
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size,NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *reImage = [self cropImage:img toRect:self.drawMaskView.fillLayerFrame];
//    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    return reImage;
}

///从图片中抠图
- (UIImage *)cropImage:(UIImage *)image toRect:(CGRect)rect {
    //2pt 是分割线宽
    CGFloat x = (rect.origin.x + 2)* [UIScreen mainScreen].scale;
    CGFloat y = (rect.origin.y + 2) * [UIScreen mainScreen].scale;
    CGFloat width = (rect.size.width - 4) * [UIScreen mainScreen].scale;
    CGFloat height = (rect.size.height - 4) * [UIScreen mainScreen].scale;
    CGRect croprect = CGRectMake(floor(x), floor(y), round(width), round(height));
//    UIImage *toCropImage = [image fixOrientation];// 纠正方向
    CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, croprect);
    UIImage *cropped = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return cropped;
}


#pragma  mark -- 选择照片 照片的逻辑开始 --
- (void)showAlertViewForPic {
    /**
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
     */
    [self imagePickerVC];

}


/**拍照*/
- (void)photoPic{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
//    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
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


/**照片选择成功（相机或者相册）*/
-(void)addImage:(UIImage*)image{
    self.imageView.image = image;
    [self configImageFrame];
}
- (void)addAssetsForChange:(NSArray *)imgeAssets {
    if (self.dataSource.count > 0) {
        NSDictionary *itemImg =  self.dataSource[self.currentPageImage];
        if (imgeAssets.count > 0) {
            PHAsset * asset = imgeAssets[0];
//            itemImg[@"imgAsset"];
            [itemImg setValue:asset forKey:@"imgAsset"];
//
            CGSize size =  CGSizeMake(asset.pixelWidth, asset.pixelHeight);
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.synchronous = NO;
            options.networkAccessAllowed = YES;
            options.resizeMode = PHImageRequestOptionsResizeModeNone;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
            WeakSelf;
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result != nil) {
                    weakSelf.imageView.image = result;
                    [weakSelf configImageFrame];
                }
            }];
            
        }
    }
}
/**图片压缩*/
//- (NSData *)configImageData:(UIImage *)image{
//   UIGraphicsBeginImageContext(CGSizeMake(image.size.width/2.0, image.size.height/2.0));
//   [image drawInRect:CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
//   UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
//   UIGraphicsEndImageContext();
//   NSData *data = UIImageJPEGRepresentation(resultImage, 0.3);
//   return data;
//}

/**上传图片*/
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


/**从相册选择*/
- (void)imagePickerVC {
    __weak typeof(self) weakSelf = self;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    // 是否允许显示视频
    imagePickerVc.allowPickingVideo =  NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.sortAscendingByModificationDate = NO;
    // 是否允许显示图片
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.allowTakePicture = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    
        if (weakSelf.dataSource.count > 0) {
            [weakSelf performSelectorOnMainThread:@selector(addAssetsForChange:) withObject:assets waitUntilDone:true];

        }
        
            UIImage* img = photos[0];
            [weakSelf performSelectorOnMainThread:@selector(addImage:) withObject:img waitUntilDone:true];
//        }
        
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationOverFullScreen;

    [self.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma  mark -- 关于照片的逻辑到此 --




- (HSDrawMaskView *)drawMaskView {
    if (_drawMaskView == nil) {
        _drawMaskView = [[HSDrawMaskView alloc] init];
    }
    return _drawMaskView;
}

- (NSMutableArray<NSMutableDictionary *> *)resultImgArray {
    if (_resultImgArray == nil) {
        _resultImgArray = [[NSMutableArray alloc] init];
    }
    return _resultImgArray;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
