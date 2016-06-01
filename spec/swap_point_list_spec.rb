require 'spec_helper'

describe FxInfoReader::SwapPointList do

  it 'initialize' do
    list = FxInfoReader::SwapPointList.new
    expect(list.all.empty?).to eq true
  end

  it 'set' do
    list = FxInfoReader::SwapPointList.new
    list.set(FxInfoReader::Pair::USD_JPY, FxInfoReader::SwapPoint.new(0, 0, 0))
    expect(list.all.length).to eq 1
  end

  it 'for each' do
    list = FxInfoReader::SwapPointList.new
    list.all.each do |pt|
    end
    list.set(FxInfoReader::Pair::USD_JPY, FxInfoReader::SwapPoint.new(0, 0, 0))

    i = 0
    list.all.each do |pt|
      i += 1
    end
    expect(i).to eq 1
  end
end
