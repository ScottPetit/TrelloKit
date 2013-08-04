Pod::Spec.new do |spec|
  spec.name = 'TrelloKit'
  spec.version = '0.0.1'
  spec.authors = {'Scott Petit' => 'petit.scott@gmail.com'}
  spec.homepage = 'https://github.com/scottpetit/TrelloKit'
  spec.summary = 'A Convenience for UICollectionView and UITableView data sources.'
  spec.source = {:git => 'https://github.com/ScottPetit/TrelloKit.git', :tag => "v#{spec.version}"}
  spec.license = { :type => 'MIT', :file => 'LICENSE' }

  spec.platform = :ios
  spec.requires_arc = true
  spec.frameworks = 'UIKit', 'Foundation'
  spec.source_files = 'TrelloKit/', 'TrelloKit/Models'
end
