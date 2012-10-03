#!/usr/bin/env ruby

require 'net/http'
# require 'hpricot'

# uri = URI("http://www.trescruces.com.uy/horarios.php?origen=1&destino=23&compania_o=0&buscar=buscar")
#
# res = Net::HTTP.get(uri)

uri = URI("http://www.trescruces.com.uy/horarios.php")
params = {
  origen: 1,
  destino: 23,
  compania_o: 0,
  buscar: 'buscar'
}
uri.query = URI.encode_www_form(params)

res = Net::HTTP.get_response(uri)
puts res.body
