require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit '/new'
    assert_selector "h1", text: "New Game"
    assert_selector "li", count: 10
    click_on "Submit"
  end
end
