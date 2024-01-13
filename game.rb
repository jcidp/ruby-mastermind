# frozen_string_literal: true

# Game class handles all game logic
class Game
  def play_game
    12.downto(1) do |turns|
      guess = gets_user_guess
      clue = get_clue guess
      return end_game("The codebreaker") if clue == %w[black black black black]

      puts "Clue: #{clue}"
      puts "#{turns - 1} turns left"
    end
    end_game("The codemaker")
  end

  private

  attr_accessor :colors, :code

  def initialize
    self.colors = %w[blue red green yellow orange purple]
    make_code
  end

  def make_code
    self.code = Array.new(4) { colors.sample }
  end

  def gets_user_guess
    puts "Write a guess of 4 colors separated by a space. Valid colors: blue, red, green, yellow, orange, and purple."
    guess = Array.new(4, "")
    until guess_valid? guess
      guess = gets.chomp.split(" ")
      puts "Invalid color. Please try again." unless guess_valid? guess
    end
    guess
  end

  def guess_valid?(guess)
    guess.all? { |color| colors.include? color }
  end

  def get_clue(guess)
    black_count = 0
    white_count = 0
    code = self.code
    guess.each_index do |i|
      next black_count += 1 if guess[i] == code[i]
      next white_count += 1 if code.include? guess[i]
    end
    clue = Array.new(black_count, "black")
    white_count.times { clue.push "white" }
    clue
  end

  def end_game(winner)
    puts "Game over! #{winner} wins the game!"
  end
end

game = Game.new
game.play_game
