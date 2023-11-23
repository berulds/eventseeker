class ApiService
  require "json"
  require "open-uri"
  def self.call_google_events_api(query, date, counter)
    date = date.gsub('-', '+')
    url = "https://serpapi.com/search.json?engine=google_events&q=#{query + '+' + date}&start=#{0 + counter}&hl=en&api_key=#{ENV["API_KEY"]}"
    puts url
    events_serialized = URI.open(url).read
    data = JSON.parse(events_serialized)
    data["events_results"]
  end

  def self.mapbox_geocode(address)
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{URI.encode_www_form_component(address)}.json?access_token=#{ENV["MAPBOX_API_KEY"]}"
    response = URI.open(url).read
    data = JSON.parse(response)
    if data['features'].present? && data['features'][0]['geometry'].present?
      coordinates = data['features'][0]['geometry']['coordinates']
      { latitude: coordinates[1], longitude: coordinates[0] }
    else
      nil
    end
  end
end
