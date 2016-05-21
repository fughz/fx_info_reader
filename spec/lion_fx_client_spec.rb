require 'spec_helper'

describe FxInfoReader::LionFxClient do
  describe 'get_swap_point_list' do
    it 'normal path' do
      expect_values = [
        {:pair => FxInfoReader::Pair::USD_JPY, :short => 1.0,  :long => 1.1, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_JPY, :short => 2.0,  :long => 2.1, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::GBP_JPY, :short => 3.0,  :long => 3.1, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::AUD_JPY, :short => 4.0,  :long => 4.1, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::NZD_JPY, :short => 5.0,  :long => 5.1, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::CAD_JPY, :short => -5.0,  :long => -5.1, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::CHF_JPY, :short => 6.0,  :long => 6.01, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::ZAR_JPY, :short => 7.0,  :long => 7.01, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::TRY_JPY, :short => 8.0,  :long => 8.01, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_USD, :short => 9.0,  :long => 9.01, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::AUD_USD, :short => 10.0, :long => 10.01, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::NZD_USD, :short => 11.0, :long => 11.01, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::USD_CHF, :short => 12.0, :long => 1.201, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::USD_CAD, :short => 13.0, :long => 1.301, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_CHF, :short => 14.0, :long => 1.401, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::GBP_CHF, :short => 1.5, :long => 1.501, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_AUD, :short => 1.6, :long => 1.601, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::AUD_NZD, :short => 1.7, :long => 1.701, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_CAD, :short => 1.8, :long => 1.801, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::AUD_CHF, :short => 1.9, :long => 1.901, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::NZD_CHF, :short => 2.0, :long => 2.001, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::NOK_JPY, :short => 2.1, :long => 2.101, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::SEK_JPY, :short => 2.2, :long => 2.201, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::SGD_JPY, :short => 2.3, :long => 2.301, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::HKD_JPY, :short => 2.40, :long => 24.01, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::MXN_JPY, :short => 2.5, :long => 2.501, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::PLN_JPY, :short => 2.6, :long => 2.601, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::HUF_JPY, :short => 2.7, :long => 2.701, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::USD_HKD, :short => 2.8, :long => 2.801, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::USD_MXN, :short => 2.9, :long => 2.901, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::USD_PLN, :short => 3.0, :long => 3.001, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::USD_SGD, :short => 3.1, :long => 3.101, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::USD_TRY, :short => 3.2, :long => 3.201, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::USD_ZAR, :short => 3.3, :long => 3.301, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_NOK, :short => 3.4, :long => 3.401, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_PLN, :short => 3.5, :long => 3.501, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_SEK, :short => 3.6, :long => 3.601, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_SGD, :short => 3.7, :long => 3.701, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_TRY, :short => 3.8, :long => 3.801, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::EUR_ZAR, :short => 3.9, :long => 3.901, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::GBP_AUD, :short => 4.0, :long => 4.001, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::GBP_CAD, :short => 4.1, :long => 4.101, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::GBP_NZD, :short => 4.2, :long => 4.201, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::AUD_CAD, :short => 4.3, :long => 4.301, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::CAD_CHF, :short => 4.4, :long => 4.401, :currency_unit => 1000},
        {:pair => FxInfoReader::Pair::NZD_CAD, :short => 4.5, :long => 4.501, :currency_unit => 1000},
      ]

      body = File.read "#{File.dirname(__FILE__)}/lion_fx_client.html"
      for expect_value in expect_values do
        pair_str = FxInfoReader::Pair.to_s(expect_value[:pair], "_")
        body.gsub!("$#{pair_str}_SHORT", expect_value[:short].to_s)
        body.gsub!("$#{pair_str}_LONG", expect_value[:long].to_s)
      end

      stub_request(:get, "http://hirose-fx.co.jp/index.php?aid=Sw_Lion").to_return(
        :status => 200,
        :headers => {},
        :body => body
      )
      client = FxInfoReader::LionFxClient.new
      list = client.get_swap_point_list

      for expect_value in expect_values do
        expect(list.get(expect_value[:pair]))
          .to eq FxInfoReader::SwapPoint.new(expect_value[:short], expect_value[:long], expect_value[:currency_unit])
      end
    end
  end
end
