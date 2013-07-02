# -*- encoding: utf-8 -*-

require File.expand_path('../lib/events', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "rbevents"
  gem.version       = Events::VERSION
  gem.summary       = %q{Events for Ruby}
  gem.description   = %q{Provides an Event mixin for enabling classes to create events for public and private subscription.}
  gem.license       = "GPL"
  gem.authors       = ["Jonny Arnold"]
  gem.email         = "jonny.arnold89@gmail.com"
  gem.homepage      = "https://github.com/jonnyarnold/rbevents"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
