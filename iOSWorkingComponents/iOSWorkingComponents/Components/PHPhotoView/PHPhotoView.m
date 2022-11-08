//
//  PHPhotoView.m
//  HSiOS
//
//  Created by wzk on 2021/11/12.
//

#import "PHPhotoView.h"
#import "HSPhotoImgItemCell.h"
#import "HSPhotoCollectionCell.h"

@interface PHPhotoView()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) NSMutableArray<PHAsset *> *modelArray;
@property (strong ,nonatomic) PHFetchResult<PHAssetCollection *> * groupNameArr;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *groupNameButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *groupAssectCollectionViewH;

@property (assign ,nonatomic) NSInteger page;
@property (strong ,nonatomic) PHAssetCollection * selectAssectCollection;

@property (strong ,nonatomic) NSMutableArray *selectArray;


@property (assign ,nonatomic) NSInteger currentPage;
@end


@implementation PHPhotoView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.groupAssectCollectionViewH.constant = 0;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"HSPhotoImgItemCell" bundle:nil] forCellWithReuseIdentifier:@"HSPhotoImgItemCell"];
    
    // 下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.collectionView.mj_header = header;
    
    // 上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"没有图片了～" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = App_999999;
    //    footer.activityIndicatorViewStyle =  UIActivityIndicatorViewStyleWhite;
    self.collectionView.mj_footer = footer;
    [self loadNewData];
    
    //相册分组
    self.groupNameArr = [[PHPicLibraryData sharedPHPicLibraryData] getOriginalGroup];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HSPhotoCollectionCell" bundle:nil] forCellReuseIdentifier:@"HSPhotoCollectionCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
}

- (void)loadNewData {
    self.page = 0;
    [self.modelArray removeAllObjects];
    WeakSelf;
    [[PHPicLibraryData sharedPHPicLibraryData] getOriginalImagesInfoResult:^(NSArray<PHAsset *> * _Nonnull resDataArr) {
        [weakSelf.modelArray addObjectsFromArray:resDataArr];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        if (resDataArr.count <= 0) {
            [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];

        }
        [weakSelf.collectionView reloadData];
    } page:self.page assetCollection:self.selectAssectCollection];
    
    if (self.selectAssectCollection == nil) {
        [self.groupNameButton setTitle:@"最近项目" forState:UIControlStateNormal];
    }
    else {
        [self.groupNameButton setTitle:self.selectAssectCollection.localizedTitle forState:UIControlStateNormal];
    }
}

- (void)loadMoreData {
    self.page ++;
    WeakSelf;
    [[PHPicLibraryData sharedPHPicLibraryData] getOriginalImagesInfoResult:^(NSArray<PHAsset *> * _Nonnull resDataArr) {
        [weakSelf.modelArray addObjectsFromArray:resDataArr];
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        if (resDataArr.count <= 0) {
            [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];

        }
        [weakSelf.collectionView reloadData];

    } page:self.page assetCollection:self.selectAssectCollection];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//指定有多少个子视图
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
   
}

//指定子视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HSPhotoImgItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HSPhotoImgItemCell" forIndexPath:indexPath];
    
    PHAsset *asset = self.modelArray[indexPath.item];
    // 是否要原图
    //CGSizeMake(asset.pixelWidth, asset.pixelHeight)
    CGSize size =  CGSizeMake(87*3, 87*3);
    // 从asset中获得图片
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
//    options.resizeMode = PHImageRequestOptionsResizeModeFast;
//    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
//    options.networkAccessAllowed = YES;
    
    __block UIImage *img = nil;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        //            NSLog(@"%@", result);
        //            completionBlock
        //            NSLog(@"图片信息%@",info);
        img = result;
        
    }];
    cell.imageView.image = img;
    cell.numBGView.tag = indexPath.item;
    cell.numBGView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectNumLabelTap:)];
    [cell.numBGView addGestureRecognizer:tap];
    cell.numLabel.text = @"";
    cell.numLabel.backgroundColor = [UIColor whiteColor];
    cell.selectedImageView.hidden = YES;
    WeakSelf;
    [self.selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = (NSDictionary *)obj;
        if ([dict[@"rowIndex"] integerValue] == indexPath.item) {
            //选中的cell
            if (weakSelf.currentPage == [dict[@"currentPage"] integerValue]) {
                //选中的cell，并且是当前页的。
                cell.numLabel.text = [NSString stringWithFormat:@"%@",dict[@"tagNumber"]];
                cell.numLabel.backgroundColor = App_UICOLOR_HEX(@"#FC3455");
            }
            else {
                //选中的cell，不是当前页的。
                cell.selectedImageView.hidden = NO;
            }
//            *stop = YES;

        }
        
    }];

    return cell;
}


#pragma mark - 点击事件 -
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    PHAsset *asset = self.modelArray[indexPath.item];
    // 是否要原图
    //CGSizeMake(asset.pixelWidth, asset.pixelHeight)
//    CGSize size =  CGSizeMake(87*3, 87*3);
//    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    options.synchronous = YES;
//    __block UIImage *img = nil;
//    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        //            NSLog(@"%@", result);
//        //            completionBlock
//        //            NSLog(@"图片信息%@",info);
//        img = result;
//
//    }];
//    PHPhotoShowBigImg *showBigImg = [[PHPhotoShowBigImg alloc] init];
//    [showBigImg selectShowBigImageView:indexPath.item dataSource:self.modelArray];
    [self selectShowBigImageView:indexPath.item];
    
}



// 表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

// 表尾尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

//返回每个子视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    CGFloat W = (App_WIDTH - 13*3)/2.0;
//    CGFloat s = W/168;
    return CGSizeMake(87, 87);
}

//设置每个子视图的缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(0, 13, 0, 13);
}

//设置子视图上下之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 13;
}

//设置子视图左右之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  13;
}


#pragma  mark -- UITableViewDelete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupNameArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSPhotoCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSPhotoCollectionCell" forIndexPath:indexPath];
    cell.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    if (indexPath.row == 0) {
        NSInteger num = [[PHPicLibraryData sharedPHPicLibraryData] systemPhotoNumberForAssetCollection:nil];
        NSString *textStr = [NSString stringWithFormat:@"%@（%ld）",@"最近项目",num];
        cell.nameLabel.attributedText = [NSString attributedTextString:textStr withFirseRange:NSMakeRange(0, @"最近项目".length) withFirstTextColor:App_333333 withFirstFont:App_SystemFont(15) withTwoRange:NSMakeRange(@"最近项目".length, [NSString stringWithFormat:@"%ld",num].length+2) withTwoColor:App_333333 withTwoFont:App_SystemFont(13)];
        cell.headImageView.image = nil;
        [[PHPicLibraryData sharedPHPicLibraryData] getOriginalFirstImagesInfoResult:^(NSArray<PHAsset *> * _Nonnull resDataArr) {
            if (resDataArr.count > 0) {
                PHAsset *asset = resDataArr[0];
                CGSize size =  CGSizeMake(87*3, 87*3);
                PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
                options.synchronous = YES;
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    cell.headImageView.image = result;
                }];
            }
        } assetCollection:nil];

    }
    else {
        PHAssetCollection *assetCollection =  self.groupNameArr[indexPath.row-1];
        NSInteger num = [[PHPicLibraryData sharedPHPicLibraryData] systemPhotoNumberForAssetCollection:assetCollection];

        NSString *textStr = [NSString stringWithFormat:@"%@（%ld）",assetCollection.localizedTitle,num];
        cell.nameLabel.attributedText = [NSString attributedTextString:textStr withFirseRange:NSMakeRange(0, assetCollection.localizedTitle.length) withFirstTextColor:App_333333 withFirstFont:App_SystemFont(15) withTwoRange:NSMakeRange(assetCollection.localizedTitle.length, [NSString stringWithFormat:@"%ld",num].length+2) withTwoColor:App_333333 withTwoFont:App_SystemFont(13)];
//        WeakSelf;
        cell.headImageView.image = nil;
        [[PHPicLibraryData sharedPHPicLibraryData] getOriginalFirstImagesInfoResult:^(NSArray<PHAsset *> * _Nonnull resDataArr) {
            if (resDataArr.count > 0) {
                PHAsset *asset = resDataArr[0];
                CGSize size =  CGSizeMake(87*3, 87*3);
                PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
                options.synchronous = YES;
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    cell.headImageView.image = result;
                }];
            }
        } assetCollection:assetCollection];
    }
    cell.headImageView.bounds = CGRectMake(0, 0, 44, 44);

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    assetCollection.localizedTitle;
//    selectAssectCollection
    if (indexPath.row == 0) {
        self.selectAssectCollection = nil;
    }
    else {
        PHAssetCollection *assetCollection =  self.groupNameArr[indexPath.row-1];
        self.selectAssectCollection = assetCollection;
    }
    
    self.groupAssectCollectionViewH.constant = 0;
    
    [UIView animateWithDuration:0.33 animations:^{
        [self layoutIfNeeded];
    }];
    
    [self loadNewData];

}



#pragma  mark -- YBImageBrowser Function
- (void)selectShowBigImageView:(NSInteger)tag{
//    self.imagePathsArray = array;
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSource = self;
    browser.currentPage = tag;
//        browser.enterTransitionType = YBImageBrowserTransitionTypeFade;
//        browser.outTransitionType = YBImageBrowserTransitionTypeFade;
    //展示
    [browser show];
}

- (NSInteger)yb_numberOfCellsInImageBrowser:(YBImageBrowser *)imageBrowser{
    return self.modelArray.count;
}

- (id<YBIBDataProtocol>)yb_imageBrowser:(YBImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index{
    PHAsset *asset = self.modelArray[index];
    YBIBImageData *data = [YBIBImageData new];
//    data.
//    CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
//    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    options.synchronous = YES;
//    __block UIImage *img = nil;
//    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//        //            NSLog(@"%@", result);
//        //            completionBlock
//        //            NSLog(@"图片信息%@",info);
//        img = result;
//
//    }];
////
//    data.image = ^UIImage * _Nullable{
//        return img;
//    };
    
    data.imagePHAsset = asset;
    data.defaultLayout.horizontalFillType = YBIBImageFillTypeCompletely;
    data.defaultLayout.verticalFillType = YBIBImageFillTypeFullWidth;
    return data;
}

#pragma  mark -- 选中图片的单选按钮事件
- (void)selectNumLabelTap:(UITapGestureRecognizer *)tap {
    UILabel *numLabel = (UILabel *)tap.view;
    if (self.selectItemNumLabelBlock) {
        PHAsset *asset = self.modelArray[numLabel.tag];

        self.selectItemNumLabelBlock(asset,self,numLabel.tag);
    }
}

- (void)reloadSelectUI:(NSMutableArray *)selectArr currentPage:(NSInteger)page allCount:(NSInteger)allCount {
    self.selectArray = selectArr;
    self.currentPage = page;
    if (allCount <= 0) {
        [self.okButton setTitle:[NSString stringWithFormat:@"确定"] forState:UIControlStateNormal];
    }
    else {
        [self.okButton setTitle:[NSString stringWithFormat:@"确定（%ld/%ld）",self.selectArray.count,allCount] forState:UIControlStateNormal];

    }
    if (self.selectArray.count >= allCount) {
        [self.okButton setTitleColor:App_UICOLOR_HEX(@"#FC3455") forState:UIControlStateNormal];
    }
    else {
        [self.okButton setTitleColor:App_UICOLOR_HEX(@"#909090") forState:UIControlStateNormal];

    }
    [self.collectionView reloadData];
}

#pragma  mark -- button action --
- (IBAction)selectGroupAssetButton:(id)sender {
    if (self.groupAssectCollectionViewH.constant == 0) {
        CGFloat contentH = (self.groupNameArr.count + 1) * 44.0;
        CGFloat maxH = self.frame.size.height - 40 - 20;
        if (contentH > maxH) {
            contentH = maxH;
        }
        self.arrowsImg.image = App_IMAGE(@"invite_card_video_photo_up_ arrows");
        self.groupAssectCollectionViewH.constant = contentH;
        [UIView animateWithDuration:0.33 animations:^{
            [self layoutIfNeeded];
        }];
    }
    else {
        self.groupAssectCollectionViewH.constant = 0;
        self.arrowsImg.image = App_IMAGE(@"invite_card_video_photo_down_ arrows");
        [UIView animateWithDuration:0.33 animations:^{
            [self layoutIfNeeded];
        }];
    }
    
}
- (IBAction)selectCancelButton:(id)sender {
    if (self.selectCancelBlock) {
        self.selectCancelBlock();
    }
}
- (IBAction)selectOKButton:(id)sender {
    if (self.selectOKBlock) {
        self.selectOKBlock();
    }
}

#pragma  mark -- getting
- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}

- (NSArray *)selectArray {
    if (_selectArray == nil) {
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _selectArray;
}





@end
