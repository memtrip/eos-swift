Pod::Spec.new do |spec|
  spec.name                   = 'eos-swift'
  spec.version                = '1.0.1'
  spec.ios.deployment_target  = '11.0'
  spec.swift_version          = '4.2'
  spec.license                = { :type => 'APACHE-2.0' }
  spec.homepage               = 'https://github.com/memtrip/eos-swft'
  spec.authors                = { 'Samuel Kirton' => 'sam@memtrip.com' }
  spec.summary                = 'EOS libraries for swift, designed primarily for iOS development.'
  spec.source                 = { :git => 'https://samkirton@bitbucket.org/samkirton/eos-swift.git', :tag => 'v1.0.1' }
  spec.source_files           = 'eos-swift/*.{swift,h,m}'
  spec.dependency               'RxSwift','~> 4.0'
  spec.dependency               'RxCocoa', '~> 4.0'
  spec.dependency               'BigInt', '~> 3.1.0'
end
