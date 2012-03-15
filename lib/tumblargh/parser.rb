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
      @structure = nil
      @config = nil
    end

    def html=(html)
      self.file = nil
      @html = html
    end

    def html
      @html ||= open(@file).read
    end

    def parse
      return @structure if @structure

      structure = @@parser.parse(html)

      if(structure.nil?)
        puts @@parser.failure_reason
        puts "#{@@parser.failure_line}:#{@@parser.failure_column}"
        raise Exception, "Parse error at offset: #{@@parser.index}"
      end

      @structure = structure.to_tree
    end

    def extract_config
      config = {}.with_indifferent_access

      doc = Nokogiri::HTML(html)
      doc.css('meta[name*=":"]').each do |meta|
        type, variable = meta['name'].split(':')
        (config[type] ||= {})[variable] = meta['content']
      end

      config
    end

  end

end
