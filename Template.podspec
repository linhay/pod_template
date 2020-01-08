Pod::Spec.new do |s|
    s.name             = 'Template'
    s.version          = '0.0.1'
    s.summary          = 'A set of useful categories for Foundation and UIKit.'
    s.homepage         = 'https://github.com/linhay/Stem.git'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lin' => 'is.linhay@outlook.com' }
    s.source = { :git => 'https://github.com/linhay/Stem.git', :tag => s.version.to_s }

    s.swift_version = "4.2"
    s.swift_versions = ['4.0', '4.2', '5.0']

    # s.default_subspecs = "UIKit"

    s.requires_arc = true

    s.ios.deployment_target     = '8.0'
    s.osx.deployment_target     = '10.10'
    s.tvos.deployment_target    = '9.0'
    s.watchos.deployment_target = '2.0'
    s.source_files = ['Sources/*.swift']

end
