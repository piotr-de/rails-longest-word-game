class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @answer = params[:answer].downcase
    @answer_array = @answer.split('')
    @letters_array = params[:letters].downcase.split('')
    @grid_valid = false
    @dict_valid = false

    @letters_check = @letters_array
    @letters_used = []

    @answer_array.each do |letter|
      if @letters_check.include? letter
        @letters_check.delete(letter)
        @letters_used << letter
      end
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    dict_response = RestClient.get(url)
    json_response = JSON.parse(dict_response)
    dict_valid = json_response["found"]

    @grid_valid = true if @letters_used == @answer_array
    if @grid_valid && dict_valid
      score = @answer_array.length
      @response = "Well done! Your score is #{score}"

    elsif @grid_valid && !dict_valid
      @response = "#{@answer} is not a valid English word"
    else
      @response = "#{@answer} cannot be built out of the letters in your grid"
    end
  end
end
