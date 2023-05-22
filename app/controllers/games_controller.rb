require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @answer = params[:word]
    p @answer
    @letters = params[:letters].split(' ')
    if check(@answer, @letters)
      if session[:score]
        session[:score] += @answer.length**2
      else
        session[:score] = 1
      end
      word_is_english?(@answer) ? @result = "Congratulation! #{@answer} is an english word - You #{session[:score]}" : @result = "Sorry but #{@answer} is not an english word"
    else
      @result = "You loose this word #{@answer} doesn't exist not an english word"
    end
  end

  def check(answer, letters)
    answer.chars.all? do |letter|
      letters.count(letter) >= answer.count(letter)
    end
  end

  def word_is_english?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    p user
    return user["found"]
  end
end
