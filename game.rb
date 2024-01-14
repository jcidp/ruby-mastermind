# frozen_string_literal: true

# Game class handles all game logic
class Game
  def setup_game
    self.user_role = choose_role
    self.code = user_role == "b" ? computer_code : user_code
    play_game
  end

  private

  attr_accessor :colors, :code, :user_role

  def initialize
    self.colors = %w[blue red green yellow orange purple]
  end

  def choose_role
    role = ""
    until %w[m b].include? role
      puts "Enter 'b' to play as the codebreaker, or 'm' to play as the codemaker."
      role = gets.chomp
      "Invalid input. Please type either 'b' or 'm' and press enter." unless %w[m b].include? role
    end
    role
  end

  def computer_code
    Array.new(4) { colors.sample }
  end

  def user_code
    puts "Write a code of 4 colors separated by a space. Valid colors: blue, red, green, yellow, orange, and purple."
    code = Array.new(4, "")
    until code_valid? code
      code = gets.chomp.split(" ")
      puts "Invalid color(s). Please try again." unless code_valid? code
    end
    code
  end

  def code_valid?(code)
    code.all? { |color| colors.include? color } && code.length == 4
  end

  def play_game
    puts "You have 12 turns to guess the code!"
    12.downto(1) do |turns|
      guess = user_role == "b" ? user_code : computer_guess
      clue = get_clue guess
      return end_game("b") if clue == %w[black black black black]

      puts "Clue: #{clue}"
      puts "#{turns - 1} turns left"
    end
    end_game("m")
  end

  def computer_guess
    guess = computer_code
    p guess
    guess
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
    puts "Game over!"
    if winner == user_role
      puts "You win the game!"
    else
      puts "The computer wins the game :("
    end
  end
end

game = Game.new
game.setup_game
