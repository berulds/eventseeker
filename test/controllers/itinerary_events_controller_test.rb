require "test_helper"

class ItineraryEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get itinerary_events_new_url
    assert_response :success
  end
end
