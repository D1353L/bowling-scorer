require_relative "frame.rb"

class Game

  FRAMES_AMOUNT = 10

  def initialize
    @frames = Array.new(FRAMES_AMOUNT) { |i| Frame.new(i+1) }
  end

  def play!
    @frames.each do |frame|
      2.times { frame.run! }
    end

    extra_rolls(@frames.last) if @frames.last.strike? || @frames.last.spare?

    print
  end

  def reset!
    initialize
  end

  def total_score
    total = 0

    @frames.each_with_index do |frame, i|
      if frame.strike? || frame.spare?
        total += calculate_bonus(frame, @frames[i+1])
        next
      end

      total += frame.total
    end
    total
  end

  def print
    @frames.each do |frame|
      p "Frame #{frame.number}: #{frame.scores}"
    end
    p "Total: #{total_score}"
  end

  private

  def calculate_bonus(frame, next_frame)
    return frame.total unless next_frame

    bonus = frame.total + next_frame.scores.first
    return bonus if frame.spare?
    return bonus + next_frame.scores[1].to_i if frame.strike?

    frame.total
  end

  def extra_rolls(frame)
    frame.add_extra_roll!
    frame.run!

    if frame.strike?
      frame.add_extra_roll!
      frame.run!
    end
  end
end
