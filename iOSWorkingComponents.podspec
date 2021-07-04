#
#  Be sure to run `pod spec lint iOSWorkingComponents.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "iOSWorkingComponents"
  spec.version      = "0.1.5"
  spec.summary      = "iOSWorkingComponentsiOS开发组件"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

  spec.description  = "iOSWorkingComponents是一款iOS开发常用工具，以组建方式存在，目前版本逐渐完善。
			iOSWorkingComponents是公共组建，从而提高工作效率。"

  spec.homepage     = "https://github.com/wzkpony/iOSWorkingComponents"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  # spec.license      = "MIT (example)"
   spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "Pony" => "1477867638@qq.com" }
  # Or just: spec.author    = "Pony"
  # spec.authors            = { "Pony" => "" }
  # spec.social_media_url   = "https://twitter.com/Pony"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

   spec.platform     = :ios
   spec.platform     = :ios, "9.0"

  #  When using multiple platforms
   spec.ios.deployment_target = "8.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/wzkpony/iOSWorkingComponents.git", :tag => "0.1.5" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "iOSWorkingComponents/iOSWorkingComponents/Components/ComponentsHeader.h"
  spec.public_header_files = "iOSWorkingComponents/iOSWorkingComponents/Components/ComponentsHeader.h"
#AppConfig目录
    spec.subspec 'AppConfig' do |ss|
    ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/AppConfig/*.{h,m}'
    end

#BaseUI目录
    spec.subspec 'BaseUI' do |ss|
    #ss.dependency 'iOSWorkingComponents/AppConfig'
    ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/BaseUI/*.{h,m}'
    end

#HUD目录
    spec.subspec 'HUD' do |ss|
    #ss.dependency 'iOSWorkingComponents/AppConfig'
    ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/HUD/MBProgressHUD+LL/*.{h,m}'
    end

#Categories目录
    spec.subspec 'Categories' do |ss|
    #ss.dependency 'iOSWorkingComponents/AppConfig'
    #ss.dependency 'iOSWorkingComponents/HUD'
    ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/Categories/**/*.{h,m}'
    end

#CalendarView目录
    #spec.subspec 'CalendarView' do |ss|
    #ss.dependency 'iOSWorkingComponents/Categories'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/CalendarView/*.{h,m}'
    #end
#RSA目录
    #spec.subspec 'RSA' do |ss|
    #ss.dependency 'iOSWorkingComponents/Categories'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/RSA/*.{h,m}'
    #end
#AppRequest目录
    #spec.subspec 'AppRequest' do |ss|
    #ss.dependency 'iOSWorkingComponents/AppRequest'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/AppRequest/*.{h,m}'
    #end
#AppDelegateCategories目录
    #spec.subspec 'AppDelegateCategories' do |ss|
    #ss.dependency 'iOSWorkingComponents/AppDelegateCategories'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/AppDelegateCategories/*.{h,m}'
    #end
#CellUI目录
    #spec.subspec 'CellUI' do |ss|
    #ss.dependency 'iOSWorkingComponents/CellUI/Cells'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/CellUI/Cells/*.{h,m}'
    #end
#ChinaCityList目录
    #spec.subspec 'ChinaCityList' do |ss|
    #ss.dependency 'iOSWorkingComponents/ChinaCityList'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/ChinaCityList/*.{h,m}','iOSWorkingComponents/iOSWorkingComponents/Components/ChinaCityList/ZYPinYinSearchLib/*.{h,m}'
    #end

#CodeTextView目录
    #spec.subspec 'CodeTextView' do |ss|
    #ss.dependency 'iOSWorkingComponents/CodeTextView'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/CodeTextView/*.{h,m}'
    #end
#CollectionImage目录
    #spec.subspec 'CollectionImage' do |ss|
    #ss.dependency 'iOSWorkingComponents/CollectionImage'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/CollectionImage/*.{h,m}'
    #end
#FileAPP目录
    #spec.subspec 'FileAPP' do |ss|
    #ss.dependency 'iOSWorkingComponents/FileAPP'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/FileAPP/*.{h,m}'
    #end
#FQPhotoAlbum目录
    #spec.subspec 'FQPhotoAlbum' do |ss|
    #ss.dependency 'iOSWorkingComponents/FQPhotoAlbum'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/FQPhotoAlbum/*.{h,m}'
    #end
#FTPopOverMenu目录
    #spec.subspec 'FTPopOverMenu' do |ss|
    #ss.dependency 'iOSWorkingComponents/FTPopOverMenu'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/FTPopOverMenu/*.{h,m}'
    #end

#GPCollectionMenuView目录
    #spec.subspec 'GPCollectionMenuView' do |ss|
    #ss.dependency 'iOSWorkingComponents/GPCollectionMenuView'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/GPCollectionMenuView/*.{h,m}'
    #end


#IMSScanner目录
    #spec.subspec 'IMSScanner' do |ss|
    #ss.dependency 'iOSWorkingComponents/IMSScanner'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/IMSScanner/*.{h,m}','iOSWorkingComponents/iOSWorkingComponents/Components/IMSScanner/IMSQRCode/*.{h,m}'
    #end
#JDAddress目录
    #spec.subspec 'JDAddress' do |ss|
    #ss.dependency 'iOSWorkingComponents/JDAddress'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/JDAddress/*.{h,m}','iOSWorkingComponents/iOSWorkingComponents/Components/JDAddress/Controller/*.{h,m}','iOSWorkingComponents/iOSWorkingComponents/Components/JDAddress/Model/*.{h,m}','iOSWorkingComponents/iOSWorkingComponents/Components/JDAddress/View/*.{h,m}'

    #end
#Location目录
    #spec.subspec 'Location' do |ss|
    #ss.dependency 'iOSWorkingComponents/Location'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/Location/gaode/*.{h,m}','iOSWorkingComponents/iOSWorkingComponents/Components/Location/baidu/*.{h,m}'
    #end
#Logs目录
    #spec.subspec 'Logs' do |ss|
    #ss.dependency 'iOSWorkingComponents/Logs'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/Logs/*.{h,m}'
    #end
#RRSwipeCell目录
    #spec.subspec 'RRSwipeCell' do |ss|
    #ss.dependency 'iOSWorkingComponents/RRSwipeCell'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/RRSwipeCell/*.{h,m}'
    #end

#SearchView目录
    #spec.subspec 'SearchView' do |ss|
    #ss.dependency 'iOSWorkingComponents/SearchView'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/SearchView/*.{h,m}'
    #end
#SelectViews目录
    #spec.subspec 'SelectViews' do |ss|
    #ss.dependency 'iOSWorkingComponents/SelectViews'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/SelectViews/*.{h,m}'
    #end
#ShareView目录
    #spec.subspec 'ShareView' do |ss|
    #ss.dependency 'iOSWorkingComponents/ShareView'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/ShareView/*.{h,m}'
    #end
#WLScrollView目录
    #spec.subspec 'WLScrollView' do |ss|
    #ss.dependency 'iOSWorkingComponents/WLScrollView'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/WLScrollView/*.{h,m}'
    #end
#WXPay目录
    #spec.subspec 'WXPay' do |ss|
    #ss.dependency 'iOSWorkingComponents/WXPay'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/WXPay/*.{h,m}'
    #end
#XASignatureView目录
    #spec.subspec 'XASignatureView' do |ss|
    #ss.dependency 'iOSWorkingComponents/XASignatureView'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/XASignatureView/*.{h,m}'
    #end
#ZJYStarRateView目录
    #spec.subspec 'ZJYStarRateView' do |ss|
    #ss.dependency 'iOSWorkingComponents/ZJYStarRateView'
    #ss.source_files = 'iOSWorkingComponents/iOSWorkingComponents/Components/ZJYStarRateView/*.{h,m}'
    #end







  #spec.exclude_files = "Classes/Exclude"



  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = ['iOSWorkingComponents/iOSWorkingComponents/Components/CalendarView/CalendarView.xib', 'Sounds/*']

    spec.resources    = [
    'iOSWorkingComponents/iOSWorkingComponents/Components/CalendarView/CalendarView.xib',
    'iOSWorkingComponents/iOSWorkingComponents/Components/Categories/NumberCalculate/resource/*png',
'iOSWorkingComponents/iOSWorkingComponents/Components/HUD/MBProgressHUD+LL/*.bundle',
'iOSWorkingComponents/iOSWorkingComponents/Components/CellUI/Cells/*.xib',
'iOSWorkingComponents/iOSWorkingComponents/Components/CellUI/Cells/Res/*.png',
'iOSWorkingComponents/iOSWorkingComponents/Components/ChinaCityList/*.png',
'iOSWorkingComponents/iOSWorkingComponents/Components/ChinaCityList/*.plist',
'iOSWorkingComponents/iOSWorkingComponents/Components/ChinaCityList/ZYPinYinSearchLib/*.txt',
'iOSWorkingComponents/iOSWorkingComponents/Components/CollectionImage/*.xib',
'iOSWorkingComponents/iOSWorkingComponents/Components/CollectionImage/*.png',
'iOSWorkingComponents/iOSWorkingComponents/Components/GPCollectionMenuView/*.xib',
'iOSWorkingComponents/iOSWorkingComponents/Components/IMSScanner/*.png',
'iOSWorkingComponents/iOSWorkingComponents/Components/Logs/*.xib',
'iOSWorkingComponents/iOSWorkingComponents/Components/SearchView/*.xib',
'iOSWorkingComponents/iOSWorkingComponents/Components/SelectViews/*.xib',
'iOSWorkingComponents/iOSWorkingComponents/Components/ShareView/*.xib',
'iOSWorkingComponents/iOSWorkingComponents/Components/ZJYStarRateView/*.png'
  ]

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

    spec.static_framework = true

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

   spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  #第三方库依赖 
   spec.ios.dependency 'WMPageController', '2.3.0'
   spec.ios.dependency 'JXCategoryView'
   spec.ios.dependency 'JKCategories',' 1.8.1'
   spec.ios.dependency 'WebViewJavascriptBridge', '~> 6.0' 
   spec.ios.dependency 'Masonry' 
   spec.ios.dependency 'FSCalendar'
   spec.ios.dependency 'SAMKeychain' 
   spec.ios.dependency 'SDWebImage' 
   spec.ios.dependency 'AFNetworking','~> 3.0' 

   spec.ios.dependency 'MBProgressHUD','1.1.0'

   spec.ios.dependency 'MJRefresh'
   spec.ios.dependency 'IQKeyboardManager'
   spec.ios.dependency 'Wonderful'
   spec.ios.dependency 'SDCycleScrollView'
   spec.ios.dependency 'TYCyclePagerView'
   spec.ios.dependency 'iCarousel','1.8.3'

   spec.ios.dependency 'NullSafe', '~> 1.2.3'
   spec.ios.dependency 'TYCyclePagerView'

   spec.ios.dependency 'DBCorner'
   spec.ios.dependency 'JPush'
   spec.ios.dependency 'LEEAlert'
   spec.ios.dependency 'YYModel'
   spec.ios.dependency 'TZImagePickerController'
   spec.ios.dependency 'BRPickerView'
   spec.ios.dependency 'YBImageBrowser'

   spec.ios.dependency 'TTTAttributedLabel'

   spec.ios.dependency 'TTGTagCollectionView'
   spec.ios.dependency 'CocoaLumberjack','~>3.5.1'
   
   spec.ios.dependency 'WechatOpenSDK'


   spec.ios.dependency 'DZNEmptyDataSet'
   spec.ios.dependency 'CL_ShanYanSDK'
   spec.ios.dependency 'YKWoodpecker'
   spec.ios.dependency 'Qiniu','8.2.0'

   spec.ios.dependency 'YYImage'
   spec.ios.dependency 'AlipaySDK-iOS'
end
