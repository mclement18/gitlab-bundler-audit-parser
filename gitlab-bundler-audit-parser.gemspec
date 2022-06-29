# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'gitlab-bundler-audit-parser'
  s.version     = '1.0.0'
  s.summary     = 'GitLab parser for bundler-audit gem output'
  s.authors     = ['Mathieu Clement']
  s.email       = 'mcfly1893@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/mclement18/gitlab-bundler-audit-parser'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.0.2'
  s.executables << 'gitlab-bundler-audit-parser'

  s.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
