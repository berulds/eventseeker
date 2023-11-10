require "test_helper"

class ItinerariesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get itineraries_new_url
    assert_response :success
  end
end
