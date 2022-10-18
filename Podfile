# Uncomment the next line to define a global platform for your project

platform :ios, '13.0'
# ignores all warnings from pods
inhibit_all_warnings!


target 'MovieApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'SnapKit'
  pod 'lottie-ios', '~> 3.1.5'

  # Pods for MovieApp

  target 'MovieAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MovieAppUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
