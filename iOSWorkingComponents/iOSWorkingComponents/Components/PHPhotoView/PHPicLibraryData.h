//
//  PHPicLibraryData.h
//  HSiOS
//
//  Created by wzk on 2021/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHPicLibraryData : NSObject
SINGLETON_FOR_HEADER(PHPicLibraryData);

///查找相册目录文件夹下的相册。
- (void)getOriginalImagesInfoResult:(void(^)(NSArray<PHAsset *> *resDataArr))completionBlock page:(NSInteger)page assetCollection:(PHAssetCollection *)assetCollection;

///获得目录下的第一张图片
- (void)getOriginalFirstImagesInfoResult:(void(^)(NSArray<PHAsset *> *resDataArr))completionBlock assetCollection:(PHAssetCollection *)assetCollection;

///获取相册目录自定义文件夹
- (PHFetchResult<PHAssetCollection *> *)getOriginalGroup;

///获取目录文件夹下的照片个数
- (NSInteger )systemPhotoNumberForAssetCollection:(PHAssetCollection *)assetCollection;

///获得所有原图
//- (void)getOriginalImagescResult:(void(^)(NSArray *resDataArr))completionBlock;
///获取所有缩略图
//- (void)getThumbnailImagesResult:(void(^)(NSArray *resDataArr))completionBlock;

@end

NS_ASSUME_NONNULL_END
