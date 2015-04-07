# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_job_example/version"

Gem::Specification.new do |spec|
  spec.name          = "active_job_example"
  spec.version       = ActiveJobExample::VERSION
  spec.authors       = ["Benjamin Fleischer"]
  spec.email         = ["github@benjaminfleischer.com"]
  spec.summary       = "Example gem that uses active job"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "activejob"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "activemodel"

  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "simplecov", "~> 0.9"
  spec.add_development_dependency "code_notes"
end
