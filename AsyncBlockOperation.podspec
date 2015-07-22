Pod::Spec.new do |s|
  s.name         = "AsyncBlockOperation"
  s.version      = "1.0.0"
  s.summary      = "NSOperation subclass for support async block."
  s.homepage     = "https://github.com/devxoul/AsyncBlockOperation"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "devxoul" => "devxoul@gmail.com" }
  s.source       = { :git => "https://github.com/devxoul/AsyncBlockOperation.git",
                     :tag => "#{s.version}" }
  s.requires_arc = true
  s.source_files = 'AsyncBlockOperation/AsyncBlockOperation.{h,m}'
  s.frameworks   = 'Foundation'

  s.ios.deployment_target = '4.3'
  s.osx.deployment_target = '10.6'
end
