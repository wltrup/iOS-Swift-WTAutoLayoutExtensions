
Pod::Spec.new do |s|
  s.name             = 'WTAutoLayoutExtensions'
  s.version          = '1.0.0'
  s.summary          = 'A set of extensions to UIView and UILayoutGuide to make it
simpler and more natural to use auto-layout.'

  s.description      = <<-DESC
    WTAutoLayoutExtensions adds extensions to UIView and UILayoutGuide to make it
    simpler and more natural to use layout guides, layout anchors, and the rest of
    the auto-layout machinery, with a consistent API and very little code.
DESC

  s.homepage         = 'https://github.com/wltrup/iOS-Swift-WTAutoLayoutExtensions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wagner Truppel' => 'trupwl@gmail.com' }
  s.source           = { :git => 'https://github.com/wltrup/iOS-Swift-WTAutoLayoutExtensions.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'WTAutoLayoutExtensions/Classes/**/*'
  s.frameworks = 'UIKit'
end
