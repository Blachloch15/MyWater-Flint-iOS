# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'MyWater-Flint' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyWater-Flint
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'RealmSwift'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'

  target 'MyWater-FlintTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MyWater-FlintUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
