class Null
  
  def to_s
    "I don't exist"
  end

  def ! 
    true
  end
  
  def nil?
    true
  end
  
  def falsey?
    true
  end
  
  def method_missing(name, *args, &block)
    self
  end

end