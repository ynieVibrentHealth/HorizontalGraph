source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def shared_pods
	pod 'SnapKit'
end

def testing_pods
	pod 'Quick'
	pod 'Nimble'
end

target 'HorizontalGraph' do
	shared_pods

end

target 'HorizontalGraphTests' do
	testing_pods
end
