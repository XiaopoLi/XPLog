Pod::Spec.new do |s|

  s.name         = "XPLog"
  s.version      = "1.0.0"
  s.summary      = "日志"
  s.description  = <<-DESC
  					根据级别打印日志，并且重定向到指定文件中
                   DESC
  s.homepage     = "https://github.com/XiaopoLi/XPLog"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Xiaopo Li" => "xiaopoli1024@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/XiaopoLi/MyProjects.git", :tag => "#{s.version}" }
  s.source_files  = "*.{h,m}"
  s.public_header_files = "*.h"
  s.requires_arc = true
end
