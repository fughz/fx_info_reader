require 'spec_helper'

include WebMock::API

describe FxInfoReader::DmmFxClient do
  describe 'get_swap_point_list' do
    it 'normal path' do
      expect_values = [
        {:pair => FxInfoReader::Pair::USD_JPY, :short => 100,  :long => 101},
        {:pair => FxInfoReader::Pair::EUR_JPY, :short => 200,  :long => 201},
        {:pair => FxInfoReader::Pair::GBP_JPY, :short => 300,  :long => 301},
        {:pair => FxInfoReader::Pair::AUD_JPY, :short => 400,  :long => 401},
        {:pair => FxInfoReader::Pair::NZD_JPY, :short => 500,  :long => 501},
        {:pair => FxInfoReader::Pair::CAD_JPY, :short => 500,  :long => 501},
        {:pair => FxInfoReader::Pair::CHF_JPY, :short => 600,  :long => 601},
        {:pair => FxInfoReader::Pair::ZAR_JPY, :short => 700,  :long => 701},
        {:pair => FxInfoReader::Pair::EUR_USD, :short => 800,  :long => 801},
        {:pair => FxInfoReader::Pair::GBP_USD, :short => 900,  :long => 901},
        {:pair => FxInfoReader::Pair::AUD_USD, :short => 1000, :long => 1001},
        {:pair => FxInfoReader::Pair::NZD_USD, :short => 1100, :long => 1101},
        {:pair => FxInfoReader::Pair::EUR_GBP, :short => 1200, :long => 1201},
        {:pair => FxInfoReader::Pair::USD_CHF, :short => 1300, :long => 1301},
        {:pair => FxInfoReader::Pair::USD_CAD, :short => 1400, :long => 1401},
        {:pair => FxInfoReader::Pair::EUR_AUD, :short => 1500, :long => 1501},
        {:pair => FxInfoReader::Pair::EUR_NZD, :short => 1600, :long => 1601},
        {:pair => FxInfoReader::Pair::EUR_CHF, :short => 1700, :long => 1701},
        {:pair => FxInfoReader::Pair::GBP_AUD, :short => 1800, :long => 1801},
        {:pair => FxInfoReader::Pair::GBP_CHF, :short => 1900, :long => 1901},
      ]

      for expect_value in expect_values do
        pair_str = FxInfoReader::Pair.to_s(expect_value[:pair], "_")
        body = File.read "#{File.dirname(__FILE__)}/dmm_fx_client/swapcalendar_#{pair_str}.json"
        body.gsub!("$#{pair_str}_SHORT", expect_value[:short].to_s)
        body.gsub!("$#{pair_str}_LONG", expect_value[:long].to_s)
        stub_request(:get, "http://fx.dmm.com/api/fx/swap/swapcalendar_#{pair_str}.json").to_return(
          :status => 200,
          :headers => {},
          :body => body
        )
      end

      client = FxInfoReader::DmmFxClient.new
      list = client.get_swap_point_list

      for expect_value in expect_values do
        expect(list.get(expect_value[:pair]))
          .to eq FxInfoReader::SwapPoint.new(expect_value[:short], expect_value[:long])
      end
    end
  end
end
