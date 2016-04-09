require 'fx_info_reader/gmo_click_fx_neo_client'
require 'fx_info_reader/fxcm_client'

class FxInfoReader::ClientFactory
  def self.create(trader)
    case trader
    when FxInfoReader::Trader::GMO_CLICK_FX_NEO
      FxInfoReader::GmoClickFxNeoClient.new
    when FxInfoReader::Trader::FXCM
      FxInfoReader::FxcmClient.new
    end
  end
end