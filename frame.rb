class Frame
  attr_reader :number, :scores

  PINS = 10

  def initialize(number)
    @number = number
    @scores = [nil, nil]
  end

  def run!
    return @scores unless @scores.last.nil?

    if @scores.first.nil?
      @scores[0] = rand(0..PINS)
      @scores.pop if strike?
    else
      pins = (total >= PINS) ? PINS : PINS - total
      next_element_index = @scores.find_index(&:nil?)
      @scores[next_element_index] = rand(0..pins)
    end

    @scores
  end

  def add_extra_roll!
    return false if @scores.size >= 3

    @scores << nil
    true
  end

  def strike?
    @scores.first == 10
  end

  def spare?
    @scores.size == 2 && total == 10
  end

  def total
    @scores.inject(0) { |sum, x| sum + x.to_i }
  end

end
