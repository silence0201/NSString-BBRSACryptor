Pod::Spec.new do |s|
  
  s.name         = "NSString+BBRSACryptor"
  s.version      = "0.1.0"
  s.summary      = "NSString+BBRSACryptor"
  s.description  = <<-DESC
  						        A Easy NSString With RSACryptor 
                   DESC

  s.homepage     = "https://github.com/silence0201/NSString-BBRSACryptor"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Silence" => "374619540@qq.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/silence0201/NSString-BBRSACryptor.git", :tag => "0.1.0" }
  s.source_files  = "NSString+BBRSACryptor", "NSString+BBRSACryptor/**/*.{h,m}"
  s.exclude_files = "NSString+BBRSACryptor/Exclude"
  s.frameworks = 'Foundation'
  s.dependency 'OpenSSL'
  s.requires_arc = true

end
