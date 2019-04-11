Pod::Spec.new do |s|
  s.name             = "ScrollKit"
  s.version          = "0.9.5.1"
  s.summary          = "Easily manage your collection view and table view data."
  s.homepage         = "https://github.com/artbobrov/ScrollKit"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Artem Bobrov" => "artembobrov3059@gmail.com" }
  s.source           = { git: "https://github.com/artbobrov/ScrollKit.git", tag: s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*.{swift}'
  s.ios.frameworks = 'UIKit', 'Foundation'
end
