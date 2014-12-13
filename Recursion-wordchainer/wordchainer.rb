require 'set'

class WordChainer
  
  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map!(&:chomp).to_set
  end
  
  # def adjacent_words(word)
  #   array_of_possible_words(word).select! {|possible_word| @dictionary.include?(possible_word)}
  # end
  
  def adjacent_words(word)
    array = []
    word.length.times do |idx|
      ("a".."z").each do |letter|
        next if word[idx] == letter
        new_word = word.dup
        new_word[idx] = letter
        array << new_word if @dictionary.include?(new_word)
      end
    end
    array
  end
  
  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }
    
    until @current_words.empty? || @all_seen_words[target] != nil
      # new_current_words = 
      @current_words = explore_current_words
    end
    build_path(target)
  end 
  
  def explore_current_words
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
      end
    end
    new_current_words
  end
  
  def build_path(target)
    result = []
    word = target
    
    while (result << word && word = @all_seen_words[word]); end
    result.reverse
  end
  
end