# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'portfolio_aggregator'
  spec.version = '0.0.0'
  spec.summary = 'A little library for portfolio tracking'
  spec.authors = ['Sruli Rapps']
  spec.email = 'srulirapps@gmail.com'
  spec.files = [
    'lib/portfolio_aggregator.rb',
    'lib/portfolio_aggregator/api.rb',
    'lib/portfolio_aggregator/date_incrementor.rb',
    'lib/portfolio_aggregator/stock.rb',
    'lib/portfolio_aggregator/stock/developed.rb',
    'lib/portfolio_aggregator/stock/emerging.rb',
    'lib/portfolio_aggregator/stock/reits.rb',
    'lib/portfolio_aggregator/stock/sp.rb',
    'lib/portfolio_aggregator/stock/treasury.rb',
    'lib/portfolio_aggregator/stock/vtip.rb'
  ]
  spec.homepage = 'https://github.com/sruli/portfolio_aggregator'
  spec.license = 'MIT'
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
