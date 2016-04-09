# coding: utf-8

class FxInfoReader::SwapPointList

  def initialize
    @list = {}
  end

  def get(pair)
    @list[pair]
  end

  def set(pair, swap_point)
    @list[pair] = swap_point
  end

  def all
    @list
  end
end
