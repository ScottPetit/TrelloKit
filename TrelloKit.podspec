Pod::Spec.new do |spec|
  spec.name = 'TrelloKit'
  spec.version = '0.1.0'
  spec.authors = {'Scott Petit' => 'petit.scott@gmail.com'}
  spec.homepage = 'https://github.com/scottpetit/TrelloKit'
  spec.summary = 'An Objective-C wrapped for the Trello API.'
  spec.source = {:git => 'https://github.com/ScottPetit/TrelloKit.git', :tag => "v#{spec.version}"}
  spec.license = { :type => 'MIT', :file => 'LICENSE' }

  spec.platform = 'ios'
  spec.ios.deployment_target = '7.0'

  spec.requires_arc = true
  spec.frameworks = 'Foundation', 'UIKit'
  spec.source_files = 'TrelloKit/', 'TrelloKit/Models', 'TrelloKit/Extensions'
  spec.dependency 'MTDates', '1.0.2'
  spec.dependency 'AFNetworking/NSURLSession', '~> 2.5.0'
end
