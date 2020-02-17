# test/system/games_test.rb
require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Submitting a random word returns a message that the word is not in the grid." do
    visit new_url
    assert test: "Random letters"
    fill_in "answer", with: "ivhoshdchkjdss"
    click_on "Play"
    assert_text "ivhoshdchkjdss cannot be built out of the letters in your grid"
  end

  test "Submitting a single letter from the grid returns a message that it’s not a valid English word" do
    visit new_url
    assert test: "Single letter from the grid"
    fill_in "answer", with: "b"
    click_on "Play"
    assert_text "b is not a valid English word"
  end

  test "Submitting 'a' returns a success message" do
    visit new_url
    assert test: "Single letter from the grid"
    fill_in "answer", with: "a"
    click_on "Play"
    assert_text "Well done!"
  end
end
