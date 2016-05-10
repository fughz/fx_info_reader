# coding: utf-8
require 'open-uri'
require 'nokogiri'

class FxInfoReader::LionFxClient

  def get_swap_point_list()
    charset = nil
    html = open("http://hirose-fx.co.jp/index.php?aid=Sw_Lion") do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)

    swap_point_list = FxInfoReader::SwapPointList.new
    doc.xpath("//*[@id='h3_text']/div[1]/div/table").each do |node|
      node.css('tr').each do |row|
        elements = row.css('td')
        pair_elem = elements.shift
        next if pair_elem.nil?

        begin
          elements.shift # day
          short_elem = elements.shift
          long_elem = elements.shift
          spoint = FxInfoReader::SwapPoint.new(Float(short_elem.text), Float(long_elem.text))
          swap_point_list.set(pair_elem.text, spoint)
        rescue
          next
        end
      end
    end
    return swap_point_list
  end
end
