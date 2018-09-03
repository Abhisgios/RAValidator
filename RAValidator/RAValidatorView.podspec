
Pod::Spec.new do |spec|

  spec.name         = "RAValidatorView"
  spec.version      = "1.0.1"
  spec.summary      = "A framework to analyse on basis of number inputs, if you are a human or robot."
  spec.description  = "An iOS Swift Framework, to Validate, if Human or a Robot operating the screen by entering the displayed number in reverse order."
  spec.homepage     = "https://github.com/Abhisgios/RAValidator"
  #spec.screenshots  = "https://image.ibb.co/fMb7Sz/Screen_Shot_2018_09_03_at_11_11_03_AM.png"
  spec.license      = "MIT"
  spec.author       = { "RamAbhishek" => "ios26jan@gmail.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/Abhisgios/RAValidator.git", :tag => "1.0.1" }
  spec.source_files  = "RAValidator/**/*.{swift,xib}" 

#spec.framework    = 'CFNetwork', 'Security', 'AdSupport', 'QuartzCore', 'CoreImage', 'ImageIO', 'SystemConfiguration', 'AudioToolbox', 'MediaPlayer', 'CoreMedia', 'AVFoundation', 'UIKit', 'Foundation', 'CoreGraphics', 'CoreFoundation'

spec.framework    = "UIKit"

end
