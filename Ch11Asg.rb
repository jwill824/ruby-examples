#!/usr/bin/ruby -w

def prompt(*args)
  input_arg=false
  until input_arg do
    print(*args)
    value=String(gets) rescue false
    input_arg=value rescue false
    if value =~ /[A-D]/ # prompt again if the argument isn't A, B, C, or D
      input_arg=true
    else
      input_arg=false
    end
  end
  return value
end

class Question
  CHOICE_INDICATORS = ["A", "B", "C", "D"]

  attr_reader :meta, :is_correct
  attr_accessor :text, :choices, :correct_answer, :user_answer

  def initialize(text = '', choices = '', correct_answer = '', user_answer = '')
    @text = text # text of the question
    @choices = choices # the multiple choice selection
    @correct_answer = correct_answer # the correct answer to the multiple choice selection
    @user_answer = '' # this is initialized as nothing, because is set after initialization occurs
    @meta = CHOICE_INDICATORS # some meta data used
    @is_correct = false # flag for checking if the question was answered wrong or not
  end

  # prints the question and the multiple choice selection
  def printText
    puts @text
    @choices.each do |choice|
      puts "#{choice.indicator}. #{choice.text}\n"
    end
    puts "\n"
  end

  # this is how the program sets the answer; it checks against the choices stored in this class and sets to the appropriate one
  def setUserAnswer(chosen_indicator)
    @choices.each do |choice|
      if chosen_indicator.match(choice.indicator)
        @user_answer = choice
      end
    end
  end

  # checks the answer to see if it's correct, and triggers the flag; also appends choices with after-analysis indicators
  def checkUserAnswer
    if @user_answer == @correct_answer
      @is_correct = true
    else
      @user_answer.indicator = "x " + @user_answer.indicator
    end
    @correct_answer.indicator = "> " + @correct_answer.indicator
  end
end

class Choice
  attr_accessor :indicator, :text

  def initialize(indicator, text)
    @indicator = indicator
    @text = text
  end
end

def selectionHash
  selection_hash = Hash.new

  selection_hash["vowel"] = "あいうえお"
  selection_hash["K"] = "かきくけこ"
  selection_hash["S"] = "さしすせそ"
  selection_hash["T"] = "たちつてと"
  selection_hash["N"] = "なにぬねの"
  selection_hash["H"] = "はひふへほ"
  selection_hash["M"] = "まみむめも"
  selection_hash["Y"] = "やゆよ"
  selection_hash["R"] = "らりるれろ"
  selection_hash["W"] = "わを"

  return selection_hash
end

def emoji_score(score)
  emoji = case score
    when 10 then ":D"
    when 8..9 then ":)"
    when 3..7 then ":/"
    when 1..5 then ":("
    else "Hmmmm..."
  end
  return emoji
end

def randomizeChoices(choices_hash, question_keys, answer_key)
  letters = Question.new.meta # gets the multiple choice letters (could potentially be modified if you wanted more choices)

  question_keys.delete(answer_key) # remove the question key from array

  # get random keys excluding the current one which is the answer key
  rand_question_keys = question_keys.sample(letters.length - 1)
  rand_question_keys.push(answer_key) # put the answer key with the random keys
  rand_question_keys = rand_question_keys.sample(letters.length) # randomize again with the answer key inserted

  # creates the choice objects sequentially with the choice text obtained from the hash map
  choices = []
  letters.each_with_index do |letter, i|
    choices << Choice.new(letter, choices_hash[rand_question_keys[i]])
  end

  question_keys.unshift(answer_key) # put question key back to beginning of array

  return choices
end

def quiz(question_text_template)
  question_keys = ["vowel", "K", "S", "T", "N", "H", "M", "Y", "R", "W"]

  questions = []
  choices_hash = selectionHash # grabs the hash map used for randomizeChoices
  question_keys.each do |key|
    choices = randomizeChoices(choices_hash, question_keys, key)
    correct_answer = choices.select{ |choice| choice.text.match(choices_hash[key]) } # grabs the correct answer and makes sure it's in the form of a choice object
    # sets the question with the text, complete list of randomized choices, and the correct choice
    question = Question.new("#{question_text_template} #{key} syllables?\n", choices, correct_answer[0])
    question.printText # prints the context for the prompt
    # you can set chosen_indicator to a letter of your choice to test (instead of being prompted 10 times)
    chosen_indicator = "C"#prompt "What's your choice? "
    puts "\n"
    question.setUserAnswer(chosen_indicator)
    question.checkUserAnswer
    questions << question
  end

  # filters through question list to check for the wrong answers indicated by the correct flag
  wrong_questions = questions.select{ |question| !question.is_correct }

  # gets the score from subtracting the array of the wrong answers from the initial questions array
  score = questions.length - wrong_questions.length

  # calculates an emoji, because why not (perks of administering a quiz)
  emoji = emoji_score(score)

  puts "\nYou scored a #{score} out of 10 #{emoji}\n\n\n"

  # first condition to display wrong questions and the appropriate answers
  if score < 10
    puts "These are the questions you got wrong: \n\n"

    wrong_questions.each do |question|
      question.printText
    end
  end

  # second condition to recurse through quiz again if the score is bad enough
  if score <= 5
    puts "\nYou got less than half right! You must retake the quiz!\n\n\n\n"
    # i know this isn't how you wanted it (more so a list of longer questions), but this is the best way
    # to represent a multiple choice quiz
    quiz("Which one of these is the correct row for hirigana") # slightly reword the questions
  end

end

quiz("What's the correct row that contains the hirigana")
