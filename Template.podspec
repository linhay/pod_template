Pod::Spec.new do |s|

  s.name         = "Template"
  s.version      = "0.0.1"
  s.summary      = "A Template library."

  s.description  = <<-DESC
                   Template is a powerful and pure Swift implemented library.
                   DESC

  s.homepage     = "https://github.com/linhay/pod_template"
  s.screenshots  = ""

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "linhey" => "is.linhey@outlook.com" }
  s.social_media_url   = "https://twitter.com/is.linhey"

  s.swift_version = "4.2"
  s.swift_versions = ['4.0', '4.2', '5.0']

  s.ios.deployment_target = "10.0"
  s.tvos.deployment_target = "10.0"
  s.osx.deployment_target = "10.12"
  s.watchos.deployment_target = "3.0"

  s.source       = { :git => "https://github.com/linhay/pod_template.git", :tag => s.version }

  s.default_subspecs = "Core"

  s.requires_arc = true
  s.frameworks = "UIKit"

  s.subspec "Core" do |sp|
    sp.source_files  = ["Sources/Core/*.swift", "Sources/Core/Template.h"]
  end

end
