require 'json'
require 'rest_client'

get '/' do
  puts "enter congress number"
  cong_num = gets.chomp
  puts "enter (h)ouse or (s)enate"
  chambre = gets.chomp.downcase
  cham = chambre == "h" ? "house" : "senate"
  enacted = true

  sunlight_api_key = ""
  sunlight_call_1 = "congress.api.sunlightfoundation.com/bills?congress="
  sunlight_call_2 = "&chamber="
  sunlight_call_3 = "&history.enacted=true&apikey="
  sunlight_request = sunlight_call_1 + cong_num + sunlight_call_2 + cham + sunlight_call_3 + sunlight_api_key

  sunlight_laws_response = JSON.load( RestClient.get( sunlight_request ) )

  laws = sunlight_laws_response["results"].each_with_object [] do |result, laws|
  # sunlight_laws_response["results"].each_with_object [] do |result, laws|
    legis = {}

      legis[:bill_id] = result["bill_id"]
      legis[:bill_type] = result["bill_type"]
      legis[:chamber] = result["chamber"]
      legis[:congress_num] = result["congress"]
      legis[:cosponsors_count] = result["cosponsors_count"]
      legis[:enacted_as_congress_num] = result["enacted_as.congress"]
      legis[:enacted_as_law_type] = result["enacted_as.law_type"]
      legis[:enacted_as_law_num] = result["enacted_as.number"]
      legis[:introduced_on] = result["introduced_on"]
      legis[:last_version_on] = result["last_version_on"]
      legis[:official_title] = result["official_title"]
      legis[:popular_title] = result["popular_title"]
      legis[:short_title] = result["short_title"]
      legis[:sponsor_id] = result["sponsor_id"]

      laws << legis
      puts "NEW LEGIS"
      puts legis.inspect
      5.times { puts "XXXXX" }
  end

  laws.each do |law|
    SunlightBill.create(law)
  end

  erb :index
end


