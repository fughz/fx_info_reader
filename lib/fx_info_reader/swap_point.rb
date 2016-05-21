# coding: utf-8

class FxInfoReader::SwapPoint
  def initialize(short, long, currency_unit)
    @short = short
    @long = long
    @currency_unit = currency_unit
  end

  def ==(rhs)
    return (
      (self.short == rhs.short) and
      (self.long == rhs.long) and
      (self.currency_unit == rhs.currency_unit))
  end

  def !=(rhs)
    return not(self.==(rhs))
  end

  attr_accessor :short, :long, :currency_unit
end
