class ScraperController < ApplicationController
  
  class Entry
    def initialize(title, minititle, body)
      @title = title
      @minititle = minititle
      @body = body
    end
    attr_reader :title
    attr_reader :minititle
    attr_reader :body
  end

  def scrape_finimize
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.finimize.com/wp/"))
  
    entries = doc.css('.article')
    @entriesArray = []
    entries.each do |entry|
      title = entry.css('h2').text #title "What's Going Here?"
      minititle = entry.css('.icon-goingon').text
      body = entry.css('p')[0].text #title "What's Going Here?"
      @entriesArray << Entry.new(title, minititle, body)
      Post.create(title: title, going_on_text: body, publish_date: DateTime.now)
    end

    # We'll just try to render the array and see what happens
    render template: 'scrape_finimize'
  end
end
