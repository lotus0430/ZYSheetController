#
# Be sure to run `pod lib lint ZYSheetController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZYSheetController'
  s.version          = '1.1.0'
  s.summary          = '扁平化的弹出框sheet'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
模仿系统UIAlertController自定义的一个扁平化的弹出框
                       DESC

  s.homepage         = 'https://github.com/lotus0430/ZYSheetController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lotus0430' => 'lotus0430@126.com' }
  s.source           = { :git => 'https://github.com/lotus0430/ZYSheetController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ZYSheetController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZYSheetController' => ['ZYSheetController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry'
end
