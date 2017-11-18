platform :ios, '9.0'

target 'cinego' do
  use_frameworks!
  
  pod 'Alamofire', '~> 4.5'
  pod 'SwiftyJSON'
  pod 'PromiseKit', '~> 4.4'
  pod 'Swinject', '~> 2.1.0'
  pod 'SwinjectStoryboard'
  pod 'HanekeSwift', :git => 'https://github.com/Haneke/HanekeSwift', :branch => 'feature/swift-3'
  

#pod 'Firebase'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'


  target 'cinegoTests' do
    pod 'Firebase'
    inherit! :search_paths
  end

  target 'cinegoUITests' do
    inherit! :search_paths
  end

end
