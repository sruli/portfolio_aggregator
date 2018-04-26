# frozen_string_literal: true

describe PortfolioAggregator::Portfolio do
  describe '.get' do
    let(:interval) { PortfolioAggregator::MONTHLY }
    subject(:portfolio) { PortfolioAggregator::Portfolio.get(portfolio_type, interval) }

    describe 'current' do
      let(:portfolio_type) { PortfolioAggregator::Portfolio::Types::CURRENT }

      it 'returns six stocks' do
        expect(portfolio.size).to eq(6)
      end

      it 'returns instance of voo' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Voo))
      end

      it 'returns instance of  vea' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Vea))
      end

      it 'returns instance of vwo' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Vwo))
      end

      it 'returns instance of vnq' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Vnq))
      end

      it 'returns instance of ief' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Ief))
      end

      it 'returns instance of vtip' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Vtip))
      end
    end

    describe 'long_term' do
      let(:portfolio_type) { PortfolioAggregator::Portfolio::Types::LONG_TERM }

      it 'returns six stocks' do
        expect(portfolio.size).to eq(6)
      end

      it 'returns instance of spy' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Spy))
      end

      it 'returns instance of efa' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Efa))
      end

      it 'returns instance of eem' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Eem))
      end

      it 'returns instance of iyr' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Iyr))
      end

      it 'returns instance of ief' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Ief))
      end

      it 'returns instance of tip' do
        expect(portfolio).to include(instance_of(PortfolioAggregator::Stock::Tip))
      end
    end
  end
end
