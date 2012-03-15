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

    def initialize(file)
      @file = file
    end

    def parse
      return @structure if @structure

      structure = @@parser.parse(read)

      if(structure.nil?)
        puts @@parser.failure_reason
        puts "#{@@parser.failure_line}:#{@@parser.failure_column}"
        raise Exception, "Parse error at offset: #{@@parser.index}"
      end

      @structure = structure.to_tree
    end

    def read
      @html ||= open(@file).read
    end

    def extract_config
      config = {}.with_indifferent_access

      doc = Nokogiri::HTML(read)
      doc.css('meta[name*=":"]').each do |meta|
        type, variable = meta['name'].split(':')
        (config[type] ||= {})[variable] = meta['content']
      end

      config
    end

  end

end
