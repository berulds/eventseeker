class ApiService
  require "json"
  require "open-uri"

  def self.call_google_events_api(query)
    apikey = "1f1ca290a118669a99ce71eaf91670d49d74de9b10e59974777bd8d7355b3909"
    url = "https://serpapi.com/search.json?engine=google_events&q=#{URI.encode_www_form_component(query)}&hl=en&gl=us&api_key=#{apikey}&start="

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
