class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

# Usage

# To find the files that are not writable
# =======================================
# expr_not_writable = Not.new( Writable.new )
# readonly_files = expr_not_writable.evaluate('test_dir')

# To find all of the files that are smaller than 1KB
# ==================================================
# small_expr = Not.new( Bigger.new(1024) )
# small_files = small_expr.evaluate('test_dir')

# To find the files that are not MP3s
# ===================================
# not_mp3_expr = Not.new( FileName.new('*.mp3') )
# not_mp3s = not_mp3_expr.evaluate('test_dir')
