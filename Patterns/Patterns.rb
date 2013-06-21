# A collection of design patterns adapted from 2008-Olsen

# Template Method. A Report Generator

## Version 1. A naive hand-coded version
class Report
  def initialize
    @title = 'Monthly Report'
    @text = [ 'Things are going', 'wicked, wicked good.' ]
  end

  def output_report
    puts('<html>')
    puts('  <head>')
    puts("    <title>#{@title}</title>")
    puts('  </head')
    puts('  <body>')
    @text.each do |line|
      puts("    <p>#{line}</p>" )
    end
    puts('  </body>')
    puts('</html>')
  end
end

# Usage
report = Report.new
report.output_report

## Version 2. Producing plain text reports as well as HTML. Still naive.
class Report
  def initialize
    @title = 'Monthly Report'
    @text =  ['Things are going', 'wicked, wicked good.']
  end

  def output_report(format)
    if format == :plain
      puts("*** #{@title} ***")
    elsif format == :html
      puts('<html>')
      puts('  <head>')
      puts("    <title>#{@title}</title>")
      puts('  </head>')
      puts('  <body>')
    else
      raise "Unknown format: #{format}"
    end

    @text.each do |line|
      if format == :plain
        puts(line)
      else
        puts("    <p>#{line}</p>" )
      end
    end

    if format == :html
      puts('  </body>')
      puts('</html>')
    end
  end
end

# Separate the Things That Stay the Same

# The code above can be improved by separating the code for
# the various formats.

# No matter which format is involved (HTML,txt, etc) the flow
# of the report remains the same:
#
# 1. Output any header information required by the specific format.
# 2. Output the title
# 3. Output each line of the actual report
# 4. Output any trailing stuff required by the format

# (quasi)-Abstract Report Class
class Report
  def initialize
    @title = 'Monthly Report'
    @text = ['Things are going', 'wicked, wicked good.']
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_start
    raise 'Called abstract method: output_start'
  end

  def output_head
    raise 'Called abstract method: output_head'
  end

  def output_body_start
    raise 'Called abstract method: output_body_start'
  end

  def output_line(line)
    raise 'Called abstract method: output_line'
  end

  def output_body_end
    raise 'Called abstract method: output_body_end'
  end

  def output_end
    raise 'Called abstract method: output_end'
  end
end

# HTML Version
class HTMLReport < Report
  def output_start
    puts('<html')
  end

  def output_head
    puts('  <head>')
    puts("    <title>#{@title}</title>")
    puts('  </head')
  end

  def output_body_start
    puts('<body>')
  end

  def output_line(line)
    puts("  <p>#{line}</p>")
  end

  def output_body_end
    puts('</body>')
  end

  def output_end
    puts('</html>')
  end
end

# Plain text version
class PlainTextReport < Report
  def output_start
  end

  def output_head
    puts("**** #{@title} ****")
    puts
  end

  def output_body_start
  end

  def output_line(line)
    puts(line)
  end

  def output_body_end
  end

  def output_end
  end
end

report = HTMLReport.new
report.output_report

report = PlainTextReport.new
report.output_report
