require 'spec_helper'

describe FxInfoReader::SwapPoint do

  it 'initialize' do
    expect(FxInfoReader::SwapPoint.new(100, 100)).not_to be nil
  end

  it '== return true' do
    lhs = FxInfoReader::SwapPoint.new(100, 100)
    rhs = FxInfoReader::SwapPoint.new(100, 100)
    expect(lhs == rhs).to be true
  end

  it '== return false' do
    lhs = FxInfoReader::SwapPoint.new(0, 100)
    rhs = FxInfoReader::SwapPoint.new(100, 0)
    expect(lhs == rhs).to be false
  end

  it '!= return true' do
    lhs = FxInfoReader::SwapPoint.new(0, 100)
    rhs = FxInfoReader::SwapPoint.new(100, 0)
    expect(lhs != rhs).to be true
  end

  it '!= return false' do
    lhs = FxInfoReader::SwapPoint.new(100, 100)
    rhs = FxInfoReader::SwapPoint.new(100, 100)
    expect(lhs != rhs).to be false
  end

end
