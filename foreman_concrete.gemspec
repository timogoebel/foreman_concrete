# frozen_string_literal: true

require File.expand_path('lib/foreman_concrete/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'foreman_concrete'
  s.version     = ForemanConcrete::VERSION
  s.license     = 'GPL-3.0'
  s.authors     = ['Timo Goebel']
  s.email       = ['mail@timogoebel.name']
  s.homepage    = 'https://github.com/timogoebel/foreman_concrete'
  s.summary     = 'Foreman plug-in to send exceptions to sentry.'
  s.description = 'Plug-in for The Foreman to send exceptions to sentry.'

  s.files = Dir['{app,lib}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']

  s.add_runtime_dependency 'sentry-raven', '~> 2.7'

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rubocop'
end
