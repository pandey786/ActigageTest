# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


def project_pods
    
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    pod 'Alamofire', '~> 4.5'
    pod 'AlamofireObjectMapper', '~> 5.0'
    pod 'Nuke', '~> 5.0'
    pod 'SVProgressHUD'
    pod 'KSToastView', '0.5.7'
    
end

target 'ActigageTest' do
    project_pods
    
end

# Pods for ActigageTest

target 'ActigageTestTests' do
    inherit! :search_paths
    # Pods for testing
    project_pods
end

target 'ActigageTestUITests' do
    inherit! :search_paths
    # Pods for testing
    project_pods
end
