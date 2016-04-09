require 'spec_helper'

describe FxInfoReader::ClientFactory do
  describe 'create' do
    it 'create GMO Click FX Neo client' do
      client = FxInfoReader::ClientFactory.create(FxInfoReader::Trader::GMO_CLICK_FX_NEO)
      expect(client.instance_of?(FxInfoReader::GmoClickFxNeoClient)).to eq true
    end
    it 'create FXCM client' do
      client = FxInfoReader::ClientFactory.create(FxInfoReader::Trader::FXCM)
      expect(client.instance_of?(FxInfoReader::FxcmClient)).to eq true
    end
  end
end
