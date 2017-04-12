class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
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
      title = entry.css('h3.icon-goingon').text #title "What's Going Here?"
      body = entry.css('p').text #title "What's Going Here?"
      @entriesArray << Entry.new(title, body)
    end
  
    # We'll just try to render the array and see what happens
    render template: 'scrape_finimize'
  end
end
