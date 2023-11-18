class ApiService
  require "json"
  require "open-uri"
  def self.call_google_events_api(query, location, date)
    date = date.gsub('-', '+')
    url = "https://serpapi.com/search.json?engine=google_events&q=#{query + '+' + date}&location=#{URI.encode_www_form_component(location + " Australia")}&hl=en&gl=au&api_key=#{ENV["API_KEY"]}"
    events_serialized = URI.open(url).read
    puts url
    data = JSON.parse(events_serialized)
    data["events_results"]
  end
end
