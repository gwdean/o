class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 & result2)
  end
end

# Usage

# To find all the big MP3 files that are not writable
# ===================================================
# complex_expression = And.new(
#                         And.new(Bigger.new(1024),
#                                 FileName.new('*.mp3')),
#                         Not.new(Writable.new ))

# Using the complex AST with different contexts
# =============================================
# complex_expression.evaluate('test_dir')
# complex_expression.evaluate('/tmp')
