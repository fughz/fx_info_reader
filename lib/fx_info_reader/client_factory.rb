require 'fx_info_reader/gmo_click_fx_neo_client'
require 'fx_info_reader/fxcm_client'
require 'fx_info_reader/dmm_fx_client'
require 'fx_info_reader/ohfx_client'

class FxInfoReader::ClientFactory
  def self.create(trader)
    case trader
    when FxInfoReader::Trader::GMO_CLICK_FX_NEO
      FxInfoReader::GmoClickFxNeoClient.new
    when FxInfoReader::Trader::FXCM
      FxInfoReader::FxcmClient.new
    when FxInfoReader::Trader::DMM_FX
      FxInfoReader::DmmFxClient.new
    when FxInfoReader::Trader::OH_FX
      FxInfoReader::OhFxClient.new
    end
  end
end
