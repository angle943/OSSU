## Solution template for Guess The Word practice problem (section 7)

require_relative './section-7-provided'

class ExtendedGuessTheWordGame < GuessTheWordGame
  ## YOUR CODE HERE
end

class ExtendedSecretWord < SecretWord
  def initialize(word)
    super

    self.pattern = ''
    word.chars.each { |ch| ch.match(/\A[a-zA-Z0-9]*\z/) ? self.pattern += "-" : self.pattern += ch }
    @guessed_words = {}
  end

  def guess_letter!(letter)
    lowercase_letter = letter.downcase
    @guessed_words[lowercase_letter] = true
    found = self.word.downcase.index lowercase_letter
    if found
      start = 0
      while ix = self.word.downcase.index(lowercase_letter, start)
        self.pattern[ix] = self.word[ix]
        start = ix + 1
      end
    end
    found
  end

  def valid_guess? guess
    if @guessed_words.key?(guess)
      return false
    end
    unless guess.match(/\A[a-zA-Z0-9]*\z/)
      return false
    end
    super(guess)
  end
end

## Change to `false` to run the original game
if true
  ExtendedGuessTheWordGame.new(ExtendedSecretWord).play
else
  GuessTheWordGame.new(SecretWord).play
end
