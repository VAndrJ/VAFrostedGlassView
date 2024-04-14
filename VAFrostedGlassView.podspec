Pod::Spec.new do |s|
  s.name             = 'VAFrostedGlassView'
  s.version          = '1.0.0'
  s.summary          = 'Frosted glass UIVisualEffectView wrapper.'

  s.description      = <<-DESC
Frosted glass UIVisualEffectView wrapper with some additions.
                       DESC

  s.homepage         = 'https://github.com/VAndrJ/VAFrostedGlassView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'VAndrJ' => 'vandrjios@gmail.com' }
  s.source           = { :git => 'https://github.com/VAndrJ/VAFrostedGlassView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/vandrj'

  s.ios.deployment_target = '13.0'

  s.source_files = 'VAFrostedGlassView/Classes/**/*'
  s.frameworks = 'UIKit'

  s.swift_versions = '5.7'
end
