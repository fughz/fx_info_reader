# coding: utf-8
require 'open-uri'
require 'nokogiri'

class FxInfoReader::FxcmClient

  def get_swap_point_list()
    charset = nil
    html = open("http://www.fxcm.co.jp/service/rate_swap.html") do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)

    swap_point_list = FxInfoReader::SwapPointList.new
    doc.xpath("//*[@id=\"fragment-2\"]/div[1]/table").each do |node|
      node.css('tr').each do |row|
        elements = row.css('td')
        pair_elem = elements.shift
        next if pair_elem.nil?

        begin
          short_elem = elements.shift
          long_elem = elements.shift

          pair = get_pair_from_text pair_elem.text
          short = short_elem.text unless short_elem.nil?
          long = long_elem.text unless long_elem.nil?
          swap_point_list.set(pair, FxInfoReader::SwapPoint.new(Integer(short), Integer(long)))
        rescue
          next
        end
      end
    end

    return swap_point_list
  end

  private
    def get_pair_from_text(text)
      FxInfoReader::Pair::all.each do |pair|
        return pair if text.include?(pair)
      end
    end
end
