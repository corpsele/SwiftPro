platform :ios, '8.0'
inhibit_all_warnings!
use_modular_headers!

target 'SwiftPro' do
    use_frameworks!
    pod 'ObjectMapper'
    pod 'SnapKit'
    pod 'lottie-ios'
    pod 'ZHRefresh'
    pod 'RealmSwift'
    pod 'IQKeyboardManager'
    pod 'CocoaLumberjack/Swift'
    pod 'Material'
    pod 'Spring'
    pod 'pop'
    pod 'JJException'
    pod 'Eureka'
    pod 'FSCalendar'
    pod 'MMKV'
    pod 'XLPagerTabStrip'
    pod 'JTAppleCalendar'
    pod 'ViewAnimator'
    pod 'TextFieldEffects'
    pod 'Starscream', :git => 'https://github.com/daltoniam/Starscream', :tag => '3.1.0'
    pod 'SwiftDate'
    pod 'SwiftCharts'
    pod 'MGSwipeTableCell'
    pod 'OOMDetector'
    pod 'AnyFormatKit'
    pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :tag => '4.2.0'
#    pod 'CellAnimatorTest'
    pod 'ReactiveSwift'
    pod 'ReactiveCocoa'
    pod 'Result'
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'AlamofireObjectMapper'
    pod 'ReachabilitySwift'
    pod 'SwiftyJSON'
    pod 'SwifterSwift'
    pod 'RxSwift'#, :git => 'https://github.com/ReactiveX/RxSwift', :tag => '5.0.1'
    pod 'RxCocoa'
    pod 'SQLite.swift'
    pod 'CryptoSwift'
    pod 'Toast-Swift'
    pod 'SwiftHEXColors'
#     pod 'Sica', :git => 'https://github.com/cats-oss/Sica', :tag => '0.4.0'
    pod 'RxAlamofire'
    pod 'RxSwiftExt'
    pod 'RxRealm'
    pod 'RxBlocking'
    pod 'RxOptional'
    pod 'RxKeyboard'
    pod 'SQLite'
    pod 'R.swift'
    pod 'SSZipArchive'
    pod 'Spring'
    pod 'SideMenu'
    pod 'Masonry'
    pod 'SDWebImage'
    pod 'RxDataSources'
    pod 'NVActivityIndicatorView'
    
    # Swift 版本声明
    post_install do |installer|
      installer.pods_project.targets.each do |target|
        if ['SideMenu'].include? target.name
          target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
          end
#          else
#          target.build_configurations.each do |config|
#            config.build_settings['SWIFT_VERSION'] = '4'
#            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
#          end
        end
        if ['Spring'].include? target.name
          target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4'
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            end
        end
      end
    end
    
    target 'SwiftProUITests' do
      
      use_frameworks!
      pod 'ObjectMapper'
      pod 'SnapKit'
      pod 'lottie-ios'
      pod 'ZHRefresh'
      pod 'RealmSwift'
      pod 'IQKeyboardManager'
      pod 'CocoaLumberjack/Swift'
      pod 'Material'
      pod 'Spring'
      pod 'pop'
      pod 'JJException'
      pod 'Eureka'
      pod 'FSCalendar'
      pod 'MMKV'
      pod 'XLPagerTabStrip'
      pod 'JTAppleCalendar'
      pod 'ViewAnimator'
      pod 'TextFieldEffects'
      pod 'Starscream', :git => 'https://github.com/daltoniam/Starscream', :tag => '3.1.0'
      pod 'SwiftDate'
      pod 'SwiftCharts'
      pod 'MGSwipeTableCell'
      pod 'OOMDetector'
      pod 'AnyFormatKit'
      pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :tag => '4.2.0'
      #    pod 'CellAnimatorTest'
      pod 'ReactiveSwift'
      pod 'ReactiveCocoa'
      pod 'Result'
      pod 'Alamofire'
      pod 'AlamofireImage'
      pod 'AlamofireObjectMapper'
      pod 'ReachabilitySwift'
      pod 'SwiftyJSON'
      pod 'SwifterSwift'
      pod 'RxSwift'#, :git => 'https://github.com/ReactiveX/RxSwift', :tag => '5.0.1'
      pod 'RxCocoa'
      pod 'SQLite.swift'
      pod 'CryptoSwift'
      pod 'Toast-Swift'
      pod 'SwiftHEXColors'
      #     pod 'Sica', :git => 'https://github.com/cats-oss/Sica', :tag => '0.4.0'
      pod 'RxAlamofire'
      pod 'RxSwiftExt'
      pod 'RxRealm'
      pod 'RxBlocking'
      pod 'RxOptional'
      pod 'RxKeyboard'
      pod 'SQLite'
      pod 'R.swift'
      pod 'SSZipArchive'
      pod 'HandyJSON'
      pod 'RxDataSources'
      pod 'NVActivityIndicatorView'
      
      # Swift 版本声明
#      post_install do |installer|
#        installer.pods_project.targets.each do |target|
#          if ['Spring', 'SideMenu'].include? target.name
#            target.build_configurations.each do |config|
#              config.build_settings['SWIFT_VERSION'] = '4'
#              config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
#            end
#            #          else
#            #          target.build_configurations.each do |config|
#            #            config.build_settings['SWIFT_VERSION'] = '4.1'
#            #            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
#            #          end
#          end
#        end
#      end

      
      end
end
