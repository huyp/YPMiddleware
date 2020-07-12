#
#  Be sure to run `pod spec lint YPMiddleware.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "YPMiddleware"
  spec.version      = "1.0.3"
  spec.summary      = "Middleware."
  spec.description  = <<-DESC
                      OC Runtime Middleware
                   DESC
  spec.homepage     = "https://github.com/huyp/YPMiddleware/blob/master/README.md"
  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "huyp" => "406468133@qq.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/huyp/YPMiddleware.git", :tag => "#{spec.version}" }
  spec.source_files  = "YPMiddleware/*.{h,m}"

end
