require 'spec_helper'

describe FxInfoReader::OhFxClient do
  describe 'get_swap_point_list' do
    it 'normal path' do
      expect_values = [
        {:pair => FxInfoReader::Pair::USD_JPY, :short => 100,  :long => 101, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::ZAR_JPY, :short => 200,  :long => 201, :currency_unit => 100000},
        {:pair => FxInfoReader::Pair::EUR_JPY, :short => 300,  :long => 301, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::SGD_JPY, :short => 400,  :long => 401, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::GBP_JPY, :short => 500,  :long => 501, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::MXN_JPY, :short => 500,  :long => 501, :currency_unit => 100000},
        {:pair => FxInfoReader::Pair::AUD_JPY, :short => 600,  :long => 601, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::TRY_JPY, :short => 700,  :long => 701, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::NZD_JPY, :short => 800,  :long => 801, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::NOK_JPY, :short => 900,  :long => 901, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::CAD_JPY, :short => 1000, :long => 1001, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::SEK_JPY, :short => 1100, :long => 1101, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::CHF_JPY, :short => 1200, :long => 1201, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::PLN_JPY, :short => 1300, :long => 1301, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::CNH_JPY, :short => 1400, :long => 1401, :currency_unit => 100000},
        {:pair => FxInfoReader::Pair::EUR_USD, :short => 1500, :long => 1501, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::HKG_JPY, :short => 1600, :long => 1601, :currency_unit => 100000},
        {:pair => FxInfoReader::Pair::GBP_USD, :short => 1700, :long => 1701, :currency_unit => 10000},
        {:pair => FxInfoReader::Pair::KRW_JPY, :short => 1800, :long => 1801, :currency_unit => 10000000},
        {:pair => FxInfoReader::Pair::AUD_USD, :short => 1900, :long => 1901, :currency_unit => 10000},
      ]

      body = File.read "#{File.dirname(__FILE__)}/ohfx_client.html"
      for expect_value in expect_values do
        pair_str = FxInfoReader::Pair.to_s(expect_value[:pair], "_")
        body.gsub!("$#{pair_str}_SHORT", expect_value[:short].to_s)
        body.gsub!("$#{pair_str}_LONG", expect_value[:long].to_s)
      end

      stub_request(:get, "https://ohfx.netbk.co.jp/nb/trade/market/swap.aspx").to_return(
        :status => 200,
        :headers => {},
        :body => body
      )
      client = FxInfoReader::OhFxClient.new
      list = client.get_swap_point_list

      for expect_value in expect_values do
        expect(list.get(expect_value[:pair]))
          .to eq FxInfoReader::SwapPoint.new(expect_value[:short], expect_value[:long], expect_value[:currency_unit])
      end
    end

    it 'empty response' do
      stub_request(:get, "https://ohfx.netbk.co.jp/nb/trade/market/swap.aspx").to_return(
        :status => 200,
        :headers => {},
        :body => ""
      )
      client = FxInfoReader::OhFxClient.new
      expect(client.get_swap_point_list.all.empty?).to eq true
    end

    it 'not found page' do
      stub_request(:get, "https://ohfx.netbk.co.jp/nb/trade/market/swap.aspx").to_return(
        :status => 404,
        :headers => {},
        :body => ""
      )
      client = FxInfoReader::OhFxClient.new
      expect{client.get_swap_point_list}.to raise_error(OpenURI::HTTPError)
    end

  end
end
