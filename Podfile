# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'simpleTestApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CalorieTracker
  pod 'R.swift'
  pod 'SwiftLint'
  pod 'ApphudSDK'
  pod 'AlignedCollectionViewFlowLayout'
  pod 'Kingfisher', '~> 7.6.1'
  pod 'Amplitude'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
