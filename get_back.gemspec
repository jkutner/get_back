# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{get_back}
  s.version = "0.0.1"
  s.authors = ["Joe Kutner"]
  s.date = Time.now
  s.description = "Easy Background Jobs for JRuby"
  s.email = ["jpkutner@gmail.com"]
  s.files = Dir['{lib,spec}/**/*'] + Dir['{*.md,*.txt,*.gemspec}']
  s.homepage = "http://github.com/jkutner/get_back"
  s.require_paths = ["lib"]
  s.summary = "Easy Background Jobs for JRuby"
  s.test_files = Dir["spec/*_spec.rb"]
  s.platform = "java"
end