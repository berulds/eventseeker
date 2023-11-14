class ApiService
  require "json"
  require "open-uri"

  def self.call_google_events_api(query)
    url = "https://serpapi.com/search.json?engine=google_events&q=#{URI.encode_www_form_component(query)}&hl=en&gl=us&api_key=#{ENV["API_KEY"]}&start="

    events_serialized = URI.open(url).read
    data = JSON.parse(events_serialized)
    # events = JSON.pretty_generate(data)
    event_results = data["events_results"]
    event_results.each do |event|
      puts event["title"]
      puts event["address"]
      puts event["date"]
      puts event["thumbnail"]
      puts "------"
    end
  end
end

# ApiServices.call_google_events_api("comedy in melbourne")
