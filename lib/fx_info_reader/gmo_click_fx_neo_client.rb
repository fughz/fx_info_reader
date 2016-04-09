# coding: utf-8
require 'open-uri'
require 'nokogiri'

class FxInfoReader::GmoClickFxNeoClient

  def get_swap_point_list()
    charset = nil
    #html = open("https://www.click-sec.com/corp/guide/fxneo/swappoint/") do |f|
    #  charset = f.charset
    #  f.read
    #end
    html = open("https://www.click-sec.com/corp/guide/fxneo/swappoint/")

    p html

    doc = Nokogiri::HTML.parse(html, nil, charset)

    swap_point_list = FxInfoReader::SwapPointList.new
    doc.xpath("//*[@id=\"fx_rate_table\"]/table").each do |node|
      node.css('tr').each do |row|
      end
    end

    return swap_point_list
  end

end
