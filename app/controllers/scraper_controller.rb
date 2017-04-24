class ScraperController < ApplicationController
  
  class Entry
    def initialize(title, body)
      @title = title
      @body = body
    end
    attr_reader :title
    attr_reader :body
  end

  def scrape_finimize
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.finimize.com/wp/"))
  
    entries = doc.css('.article')
    @entriesArray = []
    entries.each do |entry|
      title = entry.css('article--head_title').text #title "What's Going Here?"
      body = entry.css('p').text #title "What's Going Here?"
      @entriesArray << Entry.new(title, body)
      Post.create(title: title, going_on_text: body, publish_date: DateTime.now)
    end

    # We'll just try to render the array and see what happens
    render template: 'scrape_finimize'
  end
end