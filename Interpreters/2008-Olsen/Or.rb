class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end
  
  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 + result2).sort.uniq
  end
end

# Usage

# Finding all of the files that are either MP3s or writable
# =========================================================
# big_or_mp3_expr = Or.new( Bigger.new(1024), FileName.new('*.mp3') )
# big_or_mp3s = big_or_mp3_expr.evaluate('test_dir')
