# coding: utf-8

class FxInfoReader::SwapPoint
  def initialize(short, long)
    @short = short
    @long = long
  end

  def ==(rhs)
    return ((self.short == rhs.short) and (self.long == rhs.long))
  end

  def !=(rhs)
    return not(self.==(rhs))
  end

  attr_accessor :short, :long
end
