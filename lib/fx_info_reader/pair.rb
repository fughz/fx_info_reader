
module FxInfoReader::Pair
  USD_JPY = "USD/JPY"
  EUR_JPY = "EUR/JPY"
  GBP_JPY = "GBP/JPY"
  AUD_JPY = "AUD/JPY"
  NZD_JPY = "NZD/JPY"
  CAD_JPY = "CAD/JPY"
  CHF_JPY = "CHF/JPY"
  ZAR_JPY = "ZAR/JPY"
  TRY_JPY = "TRY/JPY"
  EUR_USD = "EUR/USD"
  GBP_USD = "GBP/USD"
  AUD_USD = "AUD/USD"
  NZD_USD = "NZD/USD"
  EUR_GBP = "EUR/GBP"
  EUR_AUD = "EUR/AUD"
  GBP_AUD = "GBP/AUD"
  USD_CHF = "USD/CHF"
  EUR_CHF = "EUR/CHF"
  GBP_CHF = "GBP/CHF"
  AUD_CHF = "AUD/CHF"
  NZD_CHF = "NZD/CHF"
  CAD_CHF = "CAD/CHF"
  USD_CAD = "USD/CAD"
  EUR_CAD = "EUR/CAD"
  GBP_CAD = "GBP/CAD"
  AUD_CAD = "AUD/CAD"
  NZD_CAD = "NZD/CAD"
  EUR_NZD = "EUR/NZD"
  AUD_NZD = "AUD/NZD"
  GBP_NZD = "GBP/NZD"
  USD_ZAR = "USD/ZAR"
  USD_HKD = "USD/HKD"
  USD_TRY = "USD/TRY"
  EUR_TRY = "EUR/TRY"
  UNKNOWN = "UNKNOWN"

  def self.to_s(pair, splitter)
    pair.sub("/", splitter)
  end

  def self.all
    self.constants.map{|name| self.const_get(name) }
  end
end
