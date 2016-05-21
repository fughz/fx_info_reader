# coding: utf-8
require 'kconv'
require 'open-uri'
require 'nokogiri'

class FxInfoReader::OhFxClient

  @@pair_text_table = {
    "米ドル/円" => FxInfoReader::Pair::USD_JPY,
    "南アフリカランド/円" => FxInfoReader::Pair::ZAR_JPY,
    "ユーロ/円" => FxInfoReader::Pair::EUR_JPY,
    "シンガポールドル/円" => FxInfoReader::Pair::SGD_JPY,
    "英ポンド/円" => FxInfoReader::Pair::GBP_JPY,
    "メキシコペソ/円" => FxInfoReader::Pair::MXN_JPY,
    "豪ドル/円" => FxInfoReader::Pair::AUD_JPY,
    "トルコリラ/円" => FxInfoReader::Pair::TRY_JPY,
    "NZドル/円" => FxInfoReader::Pair::NZD_JPY,
    "ノルウェークローネ/円" => FxInfoReader::Pair::NOK_JPY,
    "カナダドル/円" => FxInfoReader::Pair::CAD_JPY,
    "スウェーデンクローナ/円" => FxInfoReader::Pair::SEK_JPY,
    "スイスフラン/円" => FxInfoReader::Pair::CHF_JPY,
    "ポーランドズロチ/円" => FxInfoReader::Pair::PLN_JPY,
    "人民元/円" => FxInfoReader::Pair::CNH_JPY,
    "ユーロ/米ドル" => FxInfoReader::Pair::EUR_USD,
    "香港ドル/円" => FxInfoReader::Pair::HKG_JPY,
    "英ポンド/米ドル" => FxInfoReader::Pair::GBP_USD,
    "韓国ウォン/円" => FxInfoReader::Pair::KRW_JPY,
    "豪ドル/米ドル" => FxInfoReader::Pair::AUD_USD,
  }

  @@currency_unit_table = {
    FxInfoReader::Pair::USD_JPY => 10000,
    FxInfoReader::Pair::EUR_JPY => 10000,
    FxInfoReader::Pair::GBP_JPY => 10000,
    FxInfoReader::Pair::AUD_JPY => 10000,
    FxInfoReader::Pair::NZD_JPY => 10000,
    FxInfoReader::Pair::CAD_JPY => 10000,
    FxInfoReader::Pair::CHF_JPY => 10000,
    FxInfoReader::Pair::HKG_JPY => 100000,
    FxInfoReader::Pair::CNH_JPY => 100000,
    FxInfoReader::Pair::KRW_JPY => 10000000,
    FxInfoReader::Pair::ZAR_JPY => 100000,
    FxInfoReader::Pair::SGD_JPY => 10000,
    FxInfoReader::Pair::MXN_JPY => 100000,
    FxInfoReader::Pair::NOK_JPY => 10000,
    FxInfoReader::Pair::SEK_JPY => 10000,
    FxInfoReader::Pair::PLN_JPY => 10000,
    FxInfoReader::Pair::TRY_JPY => 10000,
    FxInfoReader::Pair::EUR_USD => 10000,
    FxInfoReader::Pair::GBP_USD => 10000,
    FxInfoReader::Pair::AUD_USD => 10000,
  }

  def get_swap_point_list()
    html = open("https://ohfx.netbk.co.jp/nb/trade/market/swap.aspx") do |f|
      Kconv.toutf8(f.read)
    end
    doc = Nokogiri::HTML.parse(html, nil, "utf-8")

    swap_point_list = FxInfoReader::SwapPointList.new
    doc.xpath("//*[@id=\"main\"]/div[2]/div/div/div[2]/div/table/tbody").each do |node|
      node.css('tr').each do |row|
        pair1, short1, long1, pair2, short2, long2 = row.element_children
        pair = get_pair_from_text(pair1.text)
        if pair != FxInfoReader::Pair::UNKNOWN
          swap_point_list.set(
            pair,
            FxInfoReader::SwapPoint.new(Integer(short1.text), Integer(long1.text), @@currency_unit_table[pair]))
        end
        pair = get_pair_from_text(pair2.text)
        if pair != FxInfoReader::Pair::UNKNOWN
          swap_point_list.set(
            pair,
            FxInfoReader::SwapPoint.new(Integer(short2.text), Integer(long2.text), @@currency_unit_table[pair]))
        end
      end
    end
    swap_point_list
  end

  private
    def get_pair_from_text(text)
      if @@pair_text_table.key? text
        return @@pair_text_table[text]
      end
      return FxInfoReader::Pair::UNKNOWN
    end
end
