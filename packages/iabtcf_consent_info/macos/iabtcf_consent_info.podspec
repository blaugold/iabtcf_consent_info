Pod::Spec.new do |s|
  s.name             = 'iabtcf_consent_info'
  s.version          = '1.0.0'
  s.summary          = 'macOS platform implementation of iabtcf_consent_info.'
  s.homepage         = 'https://github.com/blaugold/iabtcf_consent_info'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Gabriel Terwesten' => 'gabriel@terwesten.net' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
