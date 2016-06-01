require 'spec_helper'

describe FxInfoReader::SwapPoint do

  it 'initialize' do
    expect(FxInfoReader::SwapPoint.new(100, 100, 1000)).not_to be nil
  end

  it '== return true' do
    lhs = FxInfoReader::SwapPoint.new(100, 100, 1000)
    rhs = FxInfoReader::SwapPoint.new(100, 100, 1000)
    expect(lhs == rhs).to be true
  end

  it '== return false' do
    lhs = FxInfoReader::SwapPoint.new(0, 100, 0)
    rhs = FxInfoReader::SwapPoint.new(100, 0, 1000)
    expect(lhs == rhs).to be false
  end

  it '!= return true' do
    lhs = FxInfoReader::SwapPoint.new(0, 100, 1000)
    rhs = FxInfoReader::SwapPoint.new(100, 0, 1000)
    expect(lhs != rhs).to be true
  end

  it '!= return false' do
    lhs = FxInfoReader::SwapPoint.new(100, 100, 1000)
    rhs = FxInfoReader::SwapPoint.new(100, 100, 1000)
    expect(lhs != rhs).to be false
  end

  it 'short' do
    pt = FxInfoReader::SwapPoint.new(100, 0, 1000)
    expect(pt.short).to be 100
  end

  it 'long' do
    pt = FxInfoReader::SwapPoint.new(0, 100, 1000)
    expect(pt.long).to be 100
  end

  it 'currency_unit' do
    pt = FxInfoReader::SwapPoint.new(0, 0, 1000)
    expect(pt.currency_unit).to be 1000
  end

end
