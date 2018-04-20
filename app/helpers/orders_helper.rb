module OrdersHelper
  # For within US, generate random lat/lng
  # def random_lat_lng
  #   # http://en.wikipedia.org/wiki/Extreme_points_of_the_United_States#Westernmost
  #   top = 49.3457868 # north lat
  #   left = -124.7844079 # west long
  #   right = -66.9513812 # east long
  #   bottom =  24.7433195 # south lat
  #
  #   random_lat = rand(bottom..top).round(8)
  #   random_lng = rand(left..right).round(8)
  #
  #   {
  #     latitude: random_lat,
  #     longitude: random_lng
  #   }
  # end

  # def populate_buyer_data(buyer_count)
  #   i = 0
  #   while i < buyer_count do
  #     location = random_lat_lng
  #     puts location
  #     apikey = Figaro.env.google_api_key
  #
  #     places_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=" + apikey + "&location=" + location[:latitude].to_s + "," + location[:longitude].to_s + "&radius=10"
  #
  #     response = HTTParty.get(places_url)
  #     body= JSON.parse(response.body)
  #
  #     if body["results"].length > 0
  #       puts body["results"]
  #       place_id = body["results"][0]["place_id"]
  #       puts place_id
  #       place_url =  "https://maps.googleapis.com/maps/api/geocode/json?place_id=" + place_id + "&key=" + apikey
  #
  #       puts place_url
  #
  #       place_response = HTTParty.get(place_url)
  #       place_body= JSON.parse(place_response.body)
  #
  #       puts place_body["results"], place_body["results"].length
  #       i += 1
  #     end
  #   end
  # end
end
