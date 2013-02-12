# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq-nag/version'

Gem::Specification.new do |gem|
  gem.name          = "sidekiq-nag"
  gem.version       = Sidekiq::Nag::VERSION
  gem.authors       = ["Gary Greyling"]
  gem.email         = ["greyling.gary@gmail.com"]
  gem.description   = %q{A Sidekiq extension that will notify you of queues that take too long to process}
  gem.summary       = %q{Campfire notification of stationary Sidekiq queues}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('tinder')
end
