# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara-angular-tagselect/version'

Gem::Specification.new do |gem|
  gem.name          = "capybara-angular-tagselect"
  gem.version       = Capybara::AngularTagselect::VERSION
  gem.authors       = ["François Vantomme"]
  gem.email         = ["akarzim@gmail.com"]
  gem.description   = %q{Helper for triggering select for angular TagSelect directive}
  gem.summary       = ""
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rspec'
  gem.add_dependency 'capybara'
end
