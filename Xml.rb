# A simple DSL for generating XML output
# Adapted from 2008-Flanagan.(297-301)

# HAS NOT YET BEEN TESTED. LIKELY DOES NOT WORK.

class XML
  def initialize(out)
    @out = out
  end

  def content(text)
    @out << text.to_s
    nil
  end

  def comment(text)
    @out << "<!-- #{text} -->"
    nil
  end

  def tag(tagname, attributes={})
    @out << "<#{tagname}"
    attributes.each {|attr,value| @out << " #{attr}='#{value}'" }
    if block_given?
      @out << '>'
      content = yield
      if content
        @out << content.to_s
      end
      @out << "</#{tagname}>"
    else
      @out << '/>'
    end
    nil
  end
  alias method_missing tag
  def self.generate(out, &block)
    XML.new(out).instance_eval(&block)
  end
end
