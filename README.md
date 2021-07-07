
#引入方式：
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

#### ruby语法
#### target数组 如果有新的target直接加入该数组
targetsArray = ['TestF']
#### 循环
targetsArray.each do |t|
    target t do
         pod 'iOSWorkingComponents','0.1.9'
    end
end
