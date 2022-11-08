//
//  PHPicLibraryData.m
//  HSiOS
//
//  Created by wzk on 2021/11/11.
//

#import "PHPicLibraryData.h"

@interface PHPicLibraryData()

//@property (strong ,nonatomic) ;

@property (strong ,nonatomic) NSMutableArray *imgArr;

@property (copy ,nonatomic) void(^completionBlock)(NSArray<PHAsset *> *resDataArr);

@property (assign ,nonatomic) NSInteger page;
@end

@implementation PHPicLibraryData
SINGLETON_FOR_CLASS(PHPicLibraryData);

///系统最近目录个数
- (NSInteger )systemPhotoNumberForAssetCollection:(PHAssetCollection *)assetCollection {
    if (assetCollection == nil) {
        //系统最近的
        PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:cameraRoll options:nil];
        return assets.count;
    }
    else {
        //自定义的
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        return assets.count;
    }

}

///目录
- (PHFetchResult<PHAssetCollection *> *)getOriginalGroup {
    // 获得所有的自定义相簿
    
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    return assetCollections;
//    assetCollection.localizedTitle;
//    NSLog(@"分组=%@",assetCollections);
}

///获得目录下的图片
- (void)getOriginalImagesInfoResult:(void(^)(NSArray<PHAsset *> *resDataArr))completionBlock page:(NSInteger)page assetCollection:(PHAssetCollection *)assetCollection {
    self.completionBlock = nil;
    self.completionBlock = completionBlock;
    self.page = page;
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        // 获得所有的自定义相簿
//        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        // 遍历所有的自定义相簿
//        for (PHAssetCollection *assetCollection in assetCollections) {
//            [self enumerateAssetsInAssetCollection:assetCollection];
//        }

        if (assetCollection == nil) {
            // 获得相机胶卷
            PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
            [self enumerateAssetsInAssetCollection:cameraRoll];
        }
        else {
            //自定义的
            [self enumerateAssetsInAssetCollection:assetCollection];
        }
    });
   
}

///获得目录下的第一张图片
- (void)getOriginalFirstImagesInfoResult:(void(^)(NSArray<PHAsset *> *resDataArr))completionBlock assetCollection:(PHAssetCollection *)assetCollection {
    if (assetCollection == nil) {
        // 获得相机胶卷
        assetCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    }
    // 是否按创建时间排序
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.includeAssetSourceTypes = PHAssetSourceTypeUserLibrary;
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    NSMutableArray<PHAsset *> *resultImg = [[NSMutableArray alloc] init];
    if (assets.count > 0) {
        [resultImg addObject:assets[0]];
    }
    if (completionBlock) {
        completionBlock(resultImg);
    }
    
    
}

///回调NSMutableArray<PHAsset *>
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection {
//    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
//    WeakSelf;
//    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    // 同步获得图片, 只会返回1张图片
//    options.synchronous = YES;
    
    // 是否按创建时间排序
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.includeAssetSourceTypes = PHAssetSourceTypeUserLibrary;
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    /**
        在此处做分页。
     */
    NSMutableArray<PHAsset *> *imgInfoArr = [[NSMutableArray alloc] init];
    for (NSInteger i = self.page * 20; i< self.page*20 + 20; i++) {
        if (assets.count <= i) {
            //没有数据了
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.completionBlock) {
                    self.completionBlock(imgInfoArr);
                }
            });
            break;
        }
        PHAsset *asset = assets[i];
//        [imgInfoArr insertObject:asset atIndex:0];
        [imgInfoArr addObject:asset];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.completionBlock) {
            self.completionBlock(imgInfoArr);
        }
    });
    
    
}


///获得所有原图
//- (void)getOriginalImagescResult:(void(^)(NSArray<PHAsset *> *resDataArr))completionBlock {
//    // 获得所有的自定义相簿
//    [self.imgArr removeAllObjects];
//    self.completionBlock = nil;
//
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//        // 遍历所有的自定义相簿
//        for (PHAssetCollection *assetCollection in assetCollections) {
//            [self enumerateAssetsInAssetCollection:assetCollection original:YES info:NO];
//        }
//
//        // 获得相机胶卷
//        PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
//        // 遍历相机胶卷,获取大图
//        self.completionBlock = completionBlock;
//
//        [self enumerateAssetsInAssetCollection:cameraRoll original:YES info:NO];
//    });
//
//}
///获取所有缩略图
//- (void)getThumbnailImagesResult:(void(^)(NSArray<PHAsset *> *resDataArr))completionBlock {
//    [self.imgArr removeAllObjects];
//    self.completionBlock = nil;
//
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        // 获得所有的自定义相簿
//        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//        // 遍历所有的自定义相簿
//        for (PHAssetCollection *assetCollection in assetCollections) {
//            [self enumerateAssetsInAssetCollection:assetCollection original:NO info:NO];
//        }
//        // 获得相机胶卷
//        PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
//        self.completionBlock = completionBlock;
//        [self enumerateAssetsInAssetCollection:cameraRoll original:NO info:NO];
//    });
//
//}


/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
/**
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original info:(BOOL)isInfo {
//    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    WeakSelf;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;

    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
   
      //  在此处做分页。
     
    for (PHAsset *asset in assets) {
        
        
        
        
        // 是否要原图
//        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeMake(87, 87);
//
//        // 从asset中获得图片
//        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
////            NSLog(@"%@", result);
////            completionBlock
////            NSLog(@"图片信息%@",info);
//            if (isInfo) {
//                [weakSelf.imgInfoArr addObject:info];
//            }
//            else {
//                [self.imgArr addObject:result];
//            }
//        }];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.completionBlock) {
            if (isInfo) {
                
                self.completionBlock(self.imgInfoArr);
            }
            else {
                self.completionBlock(self.imgArr);
            }
        }
        
    });
    
    
}
*/





//- (NSArray *)imgInfoArr {
//    if (_imgInfoArr == nil) {
//        _imgInfoArr = [[NSMutableArray alloc] init];
//    }
//    return _imgInfoArr;
//}

- (NSArray *)imgArr {
    if (_imgArr == nil) {
        _imgArr = [[NSMutableArray alloc] init];
    }
    return _imgArr;
}

@end
