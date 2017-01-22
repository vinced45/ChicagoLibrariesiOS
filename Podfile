# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

target 'ChicagoLibraryKit' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks

  # Pods for WeatherKit
  pod 'RealmSwift', '~> 2.0.0'
  pod 'SwiftyJSON'

  target 'ChicagoLibraryKitTests' do
      inherit! :search_paths
      # Pods for testing
      pod 'ChicagoLibraryKit', :path => '.'
  end
end

target 'ChicagoLibrariesiOS' do
    #inherit! :search_paths
    pod 'ChicagoLibraryKit', :path => '.'
end

target 'Watch Extension' do
    #inherit! :search_paths
    pod 'ChicagoLibraryKit', :path => '.'
end

target 'Today' do
    #inherit! :search_paths
    pod 'ChicagoLibraryKit', :path => '.'
end

#   Disable Code Coverage for Pods projects
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
            config.build_settings['OTHER_CFLAGS'] = "$(inherited) -Qunused-arguments -Xanalyzer -analyzer-disable-all-checks"
        end
    end
end
