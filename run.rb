#!/usr/bin/env ruby

require 'net/http'
require 'hpricot'

class Record
  attr_accessor :company, :phone, :depart_time, :frequency, :road, :travel_distance, :travel_duration
end

# cities = {
#   0: "all",
#   212: "18 DE JULIO",
#   185: "25 DE AGOSTO",
#   58: "25 DE MAYO",
#   148: "AEROPUERTO",
#   27: "AGUAS DULCES",
#   149: "AIGUA",
#   88: "ARTIGAS",
#   96: "ASUNCION",
#   196: "BARKER",
#   28: "BARRA DE CHUY",
#   205: "BARRA MALDONADO",
#   150: "BATLLE Y ORDONEZ",
#   190: "BELL VILLE",
#   11: "BELLA UNION (R.3)",
#   82: "BELLA UNION (x Lit)",
#   10: "BUENOS AIRES",
#   90: "BUENOS AIRES POR COL.",
#   151: "CABO POLONIO",
#   97: "CAMBORIU",
#   197: "CANADA NIETO",
#   152: "CANELONES",
#   162: "CAPILLA DEL SAUCE",
#   48: "CARDAL",
#   9: "CARDONA",
#   22: "CARMELO",
#   29: "CASTILLOS",
#   59: "CASUPA",
#   91: "CEBOLLATI",
#   147: "CERRO CHATO",
#   164: "CERRO COLORADO",
#   23: "CHUY",
#   202: "CHUY (R.8)",
#   194: "COL. MIGUELETE",
#   75: "COL.VALDENSE",
#   6: "COLONIA",
#   15: "CORDOBA",
#   99: "CURITIBA",
#   5: "DOLORES",
#   7: "DURAZNO",
#   153: "ECILDA PAULLIER",
#   102: "FLORIANOPOLIS",
#   61: "FLORIDA",
#   60: "FLORIDA/CARD",
#   218: "FLORIDA/PAND",
#   166: "FRAILE MUERTO",
#   167: "FRAY  MARCOS",
#   2: "FRAY BENTOS",
#   83: "GUICHON",
#   172: "ISMAEL CORTINAS",
#   51: "JAUREGUIBERRY",
#   173: "JOINVILLE",
#   154: "JOSE E.RODO",
#   50: "JOSE IGNACIO",
#   73: "JOSE P.VARELA",
#   76: "JUAN LACAZE",
#   210: "KM.329 S.de YI",
#   220: "LA CHARQUEADA (TTR)",
#   65: "LA CORONILLA",
#   31: "LA FORTALEZA",
#   32: "LA PALOMA",
#   66: "LA PEDRERA",
#   215: "LAG. GARZON",
#   92: "LASCANO",
#   155: "LIBERTAD",
#   46: "MALDONADO",
#   174: "MARISCALA",
#   201: "MELO (R.7)",
#   67: "MELO (R.8)",
#   13: "MENDOZA",
#   3: "MERCEDES",
#   52: "MIGUES",
#   37: "MINAS",
#   25: "MINAS (R.7)",
#   53: "MONTES",
#   1: "MONTEVIDEO",
#   78: "NVA. HELVECIA",
#   17: "NVA. PALMIRA",
#   42: "O. LAVALLE (R.12)",
#   38: "P. DE LOS TOROS",
#   181: "PALMITAS",
#   195: "PALO SOLO",
#   211: "PALOMA DE DZNO",
#   156: "PAN DE AZUCAR",
#   157: "PANDO",
#   192: "PARANA",
#   4: "PAYSANDU",
#   64: "PAYSANDU (R.2)",
#   108: "PELOTAS",
#   43: "PIRIAPOLIS",
#   158: "PORTEZUELO",
#   109: "PORTO ALEGRE",
#   77: "PTA. COLORADA",
#   33: "PTA. DEL DIABLO",
#   44: "PTA. DEL ESTE",
#   206: "PTA. DEL ESTE (R.8)",
#   207: "PTA. DEL ESTE (R.9)",
#   170: "RADIAL J.LACAZE",
#   169: "RADIAL ROSARIO",
#   68: "RIO BRANCO",
#   179: "RIO CUARTO",
#   16: "RIVERA",
#   34: "ROCHA",
#   79: "ROSARIO",
#   114: "ROSARIO (R.A.)",
#   69: "SALTO",
#   214: "SAN BAUTISTA",
#   35: "SAN CARLOS",
#   193: "SAN FRANCISCO (R.A)",
#   186: "SAN GABRIEL",
#   85: "SAN GREGORIO",
#   62: "SAN JACINTO",
#   36: "SAN JOSE",
#   224: "SAN JOSE (R.45)",
#   63: "SAN JOSE/CAN",
#   56: "SAN LUIS",
#   115: "SAN PABLO",
#   163: "SAN RAMON",
#   94: "SARANDI DEL YI",
#   93: "SARANDI GDE.",
#   160: "SOCA",
#   159: "SOLIS DE MATAOJO",
#   54: "STA. ANA",
#   182: "STA. CATALINA",
#   161: "STA. CLARA DE OLIMAR",
#   117: "STA. FE (R.A.)",
#   183: "STA. LUCIA",
#   55: "STA. LUCIA DEL ESTE",
#   213: "STA. ROSA",
#   14: "STGO. DE CHILE",
#   39: "T. Y TRES",
#   70: "TACUAREMBO",
#   26: "TALA",
#   87: "TARARIRAS",
#   138: "TIGRE BS.AS.",
#   89: "TRANQUERAS",
#   71: "TRINIDAD",
#   165: "TUPAMBAE",
#   24: "VALIZAS",
#   168: "VELAZQUEZ",
#   178: "VENADO TUERTO",
#   177: "VERGARA",
#   191: "VILLA MARIA",
#   180: "VILLA MERCEDES",
#   184: "VILLA RODRIGUEZ",
#   72: "YOUNG",
#   95: "ZAPICAN"
# }

# You can invoke it as follows (montevideo - minas):
#   ./run.rb 1 25
#
# Defaults:
#   from: Montevideo (1)
#   to:   Chuy (23)
#
uri = URI("http://www.trescruces.com.uy/horarios.php")
params = {
  origen: ARGV[0] ? ARGV[0] : 1,
  destino: ARGV[1] ? ARGV[1] : 23,
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
