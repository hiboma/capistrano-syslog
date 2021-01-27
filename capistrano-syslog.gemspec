# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/syslog/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-syslog"
  spec.version       = Capistrano::Syslog::VERSION
  spec.authors       = ["hiboma"]
  spec.email         = ["hiroyan@gmail.com"]
  spec.summary       = %q{Capistrano v3 plugin to syslog}
  spec.description   = %q{Capistrano v3 plugin to syslog current_revision by using logger}
  spec.homepage      = "https://github.com/hiboma/capistrano-syslog"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.1"

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 10.0"
end
