require 'treetop'
require 'open-uri'

module Tumblargh

  class Parser
    Treetop.load(File.join(File.dirname(__FILE__), 'grammar.treetop'))
    @@parser = TumblrParser.new
    # @@parser.consume_all_input = false

    def parse_uri(file)
      parse open(file).read
    end

    def parse(data)
      # TODO
      data.gsub! /<script.+?<\/script>/mi, ''

      structure = @@parser.parse(data)

      if(structure.nil?)
        puts @@parser.failure_reason
        puts "#{@@parser.failure_line}:#{@@parser.failure_column}"
        raise Exception, "Parse error at offset: #{@@parser.index}"
      end

      structure.to_tree
    end

  end

end
