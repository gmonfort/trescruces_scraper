#!/usr/bin/env ruby

require 'net/http'
require 'hpricot'

class Record
  attr_accessor :company, :phone, :depart_time, :frequency, :road, :travel_distance, :travel_duration
end

uri = URI("http://www.trescruces.com.uy/horarios.php")
params = {
  origen: 1,
  destino: 23,
  compania_o: 0,
  buscar: 'buscar'
}
uri.query = URI.encode_www_form(params)

res = Net::HTTP.get_response(uri)

if res.is_a?(Net::HTTPSuccess)
  doc = Hpricot(res.body)
  table = doc.at("#horariosdiv table")
  data = table.search('tr')

  records = []

  data.each do |tr|
    record = Record.new
    record.company          = tr.search('td')[0].inner_html
    record.phone            = tr.search('td')[1].inner_html
    record.depart_time      = tr.search('td')[2].inner_html
    record.frequency        = tr.search('td')[3].inner_html
    record.road             = tr.search('td')[4].inner_html
    record.travel_distance  = tr.search('td')[5].inner_html
    record.travel_duration  = tr.search('td')[6].inner_html

    records << record
  end

  records.each {|r| puts r.inspect }
else
  puts "Error: %s" % res.inspect
end
