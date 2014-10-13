class RPNCalculator
  attr_reader :value

  def initialize
    @stack = []
  end

  def push(value)
    @stack.push(value)
  end

  def calc(process)
    if @stack.length < 2
      raise "calculator is empty"
    else
      val1 = @stack.pop.to_f
      val2 = @stack.pop.to_f
      @stack.push(val2.send(process, val1))
    end
  end

  def plus
    calc(:+)
  end

  def minus
    calc(:-)
  end

  def times
    calc(:*)
  end

  def divide
    calc(:/)
  end

  def value
    @stack[@stack.length-1]
  end

  def tokens(str)
    str.split(" ").map{|c| is_i?(c) ? c.to_i : c.to_sym }
  end

  def evaluate(str)
    self.tokens(str).each do |x|
        if x.is_a?(Numeric)
           self.push(x)
        else
            self.calc(x)
        end
      end

      self.value
  end
  
  private
    def is_i?(c)
       !!(c =~ /\A[-+]?[0-9]+\z/)
     end

end

if __FILE__ == $PROGRAM_NAME
  calculator = RPNCalculator.new
  if !ARGV.empty?
    File.readlines(ARGV.first).each do |line|
      puts line
      puts calculator.evaluate(line.chomp)
    end
  else
    loop do    
      string = gets.chomp
      puts calculator.evaluate(string)
    end
  end
end