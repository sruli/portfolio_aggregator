# frozen_string_literal: true

Gem::Specification.new do |spec| # rubocop:disable BlockLength
  spec.name = 'portfolio_aggregator'
  spec.version = '0.0.0'
  spec.summary = 'A little library for portfolio tracking'
  spec.authors = ['Sruli Rapps']
  spec.email = 'srulirapps@gmail.com'
  spec.files = [
    'lib/portfolio_aggregator.rb',
    'lib/portfolio_aggregator/api.rb',
    'lib/portfolio_aggregator/date_manager.rb',
    'lib/portfolio_aggregator/portfolio.rb',
    'lib/portfolio_aggregator/stock.rb',
    'lib/portfolio_aggregator/stock/eem.rb',
    'lib/portfolio_aggregator/stock/efa.rb',
    'lib/portfolio_aggregator/stock/ief.rb',
    'lib/portfolio_aggregator/stock/iyr.rb',
    'lib/portfolio_aggregator/stock/spy.rb',
    'lib/portfolio_aggregator/stock/tip.rb',
    'lib/portfolio_aggregator/stock/vea.rb',
    'lib/portfolio_aggregator/stock/vnq.rb',
    'lib/portfolio_aggregator/stock/voo.rb',
    'lib/portfolio_aggregator/stock/vtip.rb',
    'lib/portfolio_aggregator/stock/vwo.rb'
  ]
  spec.homepage = 'https://github.com/sruli/portfolio_aggregator'
  spec.license = 'MIT'
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
