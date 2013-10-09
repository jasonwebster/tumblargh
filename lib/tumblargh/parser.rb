require 'treetop'
require 'open-uri'
require 'nokogiri'

module Tumblargh
  class ParserError < StandardError
  end

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
      @structure = nil
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

    def to_s
      parse unless @structure
      @structure.to_s
    end

    private

    def parse
      @structure = @@parser.parse(html)

      if @structure.nil?
        raise ParserError, @@parser.failure_reason
      end

      @tree = @structure.to_tree
    end

    def extract_options
      opts = {}.with_indifferent_access

      doc = Nokogiri::HTML(html)
      doc.css('meta[name*=":"]').each do |meta|
        type, variable = meta['name'].downcase.split(':')
        variable.gsub!(/\s/, '')

        default = meta['content']

        default = case type
        when "if"
          default == "1"
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
