class Animation
  attr_accessor :start, :finish, :on_finished
  def initialize(start, finish, on_finished = Null.new)
    @start = start; @finish = finish; @on_finished = on_finished
  end
end