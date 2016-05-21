require 'spec_helper'

include WebMock::API

describe FxInfoReader::FxcmClient do
  describe 'get_swap_point_list' do
    it 'normal path' do
      expect_values = [
        {:pair => FxInfoReader::Pair::EUR_USD, :short => 100,  :long => 101, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::EUR_JPY, :short => 200,  :long => 201, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::GBP_JPY, :short => 300,  :long => 301, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::CHF_JPY, :short => 400,  :long => 401, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::GBP_CHF, :short => 500,  :long => 501, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::EUR_AUD, :short => 600,  :long => 601, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::EUR_CAD, :short => 700,  :long => 701, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::AUD_CAD, :short => 800,  :long => 801, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::AUD_JPY, :short => 900,  :long => 901, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::CAD_JPY, :short => 1000, :long => 1001, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::NZD_JPY, :short => 1100, :long => 1101, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::USD_JPY, :short => 1200, :long => 1201, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::GBP_CAD, :short => 1300, :long => 1301, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::GBP_NZD, :short => 1400, :long => 1401, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::GBP_AUD, :short => 1500, :long => 1501, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::AUD_NZD, :short => 1600, :long => 1601, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::GBP_USD, :short => 1700, :long => 1701, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::AUD_CHF, :short => 1800, :long => 1801, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::USD_CHF, :short => 1900, :long => 1901, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::EUR_NZD, :short => 2000, :long => 2001, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::USD_ZAR, :short => 2100, :long => 2101, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::EUR_CHF, :short => 2200, :long => 2201, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::USD_HKD, :short => 2300, :long => 2301, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::AUD_USD, :short => 2400, :long => 2401, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::USD_CAD, :short => 2500, :long => 2501, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::ZAR_JPY, :short => 2600, :long => 2601, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::NZD_USD, :short => 2700, :long => 2701, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::USD_TRY, :short => 2800, :long => 2801, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::EUR_TRY, :short => 2900, :long => 2901, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::NZD_CHF, :short => 3000, :long => 3001, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::EUR_GBP, :short => 3100, :long => 3101, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::CAD_CHF, :short => 3200, :long => 3201, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::NZD_CAD, :short => 3300, :long => 3301, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::TRY_JPY, :short => 3400, :long => 3401, :currency_unit => 10000},
      ]

      body = File.read "#{File.dirname(__FILE__)}/fxcm_client.html"
      for expect_value in expect_values do
        body.gsub!("<!--$#{expect_value[:pair]}_SHORT-->", expect_value[:short].to_s)
        body.gsub!("<!--$#{expect_value[:pair]}_LONG-->",  expect_value[:long].to_s)
      end
      stub_request(:get, "http://www.fxcm.co.jp/service/rate_swap.html").to_return(
        :status => 200,
        :headers => {},
        :body => body
      )
      client = FxInfoReader::FxcmClient.new
      list = client.get_swap_point_list
      for expect_value in expect_values do
        expect(list.get(expect_value[:pair]))
          .to eq FxInfoReader::SwapPoint.new(expect_value[:short], expect_value[:long], expect_value[:currency_unit])
      end
    end
  end
end
