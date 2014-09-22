# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'progress_job/version'

Gem::Specification.new do |spec|
  spec.name          = "progress_job"
  spec.version       = ProgressJob::VERSION
  spec.authors       = ["Stjepan Hadjic"]
  spec.email         = ["d4be4st@gmail.com"]
  spec.summary       = %q{Delayed jobs with progress.}
  spec.description   = %q{Add progress feature to delayed jobs}
  spec.homepage      = "https://github.com/d4be4st/progress_job"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency 'delayed_job'
end
