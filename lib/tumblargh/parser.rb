require 'treetop'
require 'open-uri'
require 'nokogiri'

module Tumblargh

  class Parser
    grammar_file = File.join(File.dirname(__FILE__), 'grammar')

    if File.exists?("#{grammar_file}.rb")
      require "#{grammar_file}.rb"
    else
      Treetop.load("#{grammar_file}.treetop")
    end

    @@parser = TumblrParser.new

    def initialize(template=nil)
      self.file = template
    end

    attr_reader :file

    def file=(file)
      @file = file
      @html = nil
      @tree = nil
      @config = nil
    end

    def html=(html)
      self.file = nil
      @html = html
    end

    def html
      @html ||= open(@file).read
    end

    def tree
      @tree ||= parse
    end

    def options
      @options ||= extract_options
    end

    private

    def parse
      structure = @@parser.parse(html)

      if(structure.nil?)
        puts @@parser.failure_reason
        puts "#{@@parser.failure_line}:#{@@parser.failure_column}"
        raise Exception, "Parse error at offset: #{@@parser.index}"
      end

      @tree = structure.to_tree
    end

    def extract_options
      opts = {}.with_indifferent_access

      doc = Nokogiri::HTML(html)
      doc.css('meta[name*=":"]').each do |meta|
        type, variable = meta['name'].split(':')
        default = meta['content']

        default = case type
        when "if"
          default == "1" ? true : false
        else
          default
        end

        opts[type] ||= {}
        opts[type][variable] = default
      end

      opts
    end

  end

end
