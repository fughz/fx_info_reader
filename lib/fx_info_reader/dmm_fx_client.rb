# coding: utf-8
require 'open-uri'
require 'json'

class FxInfoReader::DmmFxClient

  def get_swap_point_list()
    source_list = [
      {:pair => FxInfoReader::Pair::USD_JPY, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_USD_JPY.json"},
      {:pair => FxInfoReader::Pair::EUR_JPY, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_EUR_JPY.json"},
      {:pair => FxInfoReader::Pair::GBP_JPY, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_GBP_JPY.json"},
      {:pair => FxInfoReader::Pair::AUD_JPY, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_AUD_JPY.json"},
      {:pair => FxInfoReader::Pair::NZD_JPY, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_NZD_JPY.json"},
      {:pair => FxInfoReader::Pair::CAD_JPY, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_CAD_JPY.json"},
      {:pair => FxInfoReader::Pair::CHF_JPY, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_CHF_JPY.json"},
      {:pair => FxInfoReader::Pair::ZAR_JPY, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_ZAR_JPY.json"},
      {:pair => FxInfoReader::Pair::EUR_USD, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_EUR_USD.json"},
      {:pair => FxInfoReader::Pair::GBP_USD, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_GBP_USD.json"},
      {:pair => FxInfoReader::Pair::AUD_USD, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_AUD_USD.json"},
      {:pair => FxInfoReader::Pair::NZD_USD, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_NZD_USD.json"},
      {:pair => FxInfoReader::Pair::EUR_GBP, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_EUR_GBP.json"},
      {:pair => FxInfoReader::Pair::USD_CHF, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_USD_CHF.json"},
      {:pair => FxInfoReader::Pair::USD_CAD, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_USD_CAD.json"},
      {:pair => FxInfoReader::Pair::EUR_AUD, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_EUR_AUD.json"},
      {:pair => FxInfoReader::Pair::EUR_NZD, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_EUR_NZD.json"},
      {:pair => FxInfoReader::Pair::EUR_CHF, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_EUR_CHF.json"},
      {:pair => FxInfoReader::Pair::GBP_AUD, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_GBP_AUD.json"},
      {:pair => FxInfoReader::Pair::GBP_CHF, :url => "http://fx.dmm.com/api/fx/swap/swapcalendar_GBP_CHF.json"},
    ]

    swap_point_list = FxInfoReader::SwapPointList.new
    for source in source_list do
      json_source = open(source[:url]) do |f|
        f.read
      end
      json = JSON.parse json_source
      swap = json["body"]["swap"].last
      long = swap["buySwapAmount"]
      short = swap["sellSwapAmount"]
      swap_point_list.set(
        source[:pair],
        FxInfoReader::SwapPoint.new(Integer(short), Integer(long), 10000))
    end

    return swap_point_list
  end

end
