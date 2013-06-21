class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results= []
    Find.find(dir) do |p|
      next unless File.file?(p)
      name = File.basename(p)
      results << p if File.fnmatch(@pattern, name)
    end
    results
  end
end

# Usage

# Finding All Files
# =================
# expr_all = All.new
# files = expr_all.evaluate('test_dir')

# Finding Only MP3s
# =================
# expr_mp3 = FileName.new('*.mp3')
# mp3s = expr_mp3.evaluate('test_dir')

# Finding all the MP3s in my music directory
# ==========================================
# other_mp3s = expr_mp3.evaluate('music_dir')

