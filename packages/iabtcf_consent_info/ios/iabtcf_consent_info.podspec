Pod::Spec.new do |s|
  s.name             = 'iabtcf_consent_info'
  s.version          = '1.0.0'
  s.summary          = 'iOS platform implementation of iabtcf_consent_info.'
  s.homepage         = 'https://github.com/blaugold/iabtcf_consent_info'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Gabriel Terwesten' => 'gabriel@terwesten.net' }
  s.source           = { :path => '.' }
  s.ios.deployment_target = '9.0'
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version    = '5.0'
end
