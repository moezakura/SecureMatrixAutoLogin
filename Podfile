# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'SecureMatrixAutoLogin' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'TextFieldEffects'

  # Pods for SecureMatrixAutoLogin

  target 'SecureMatrixAutoLoginTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SecureMatrixAutoLoginUITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|  
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end

end
