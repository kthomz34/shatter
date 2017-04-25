class ScraperController < ApplicationController
  
  class Entry
    def initialize(title, going_on_text, meant_text, care_text, bigger_picture_text, publish_date)
      @title = title
      @going_on_text = going_on_text
      @meant_text = meant_text
      @care_text = care_text
      @bigger_picture_text = bigger_picture_text
      @publish_date = publish_date
    end
    attr_reader :title
    attr_reader :going_on_text
    attr_reader :meant_text
    attr_reader :care_text
    attr_reader :publish_date
    attr_reader :bigger_picture_text
  end

  def scrape_finimize
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.finimize.com/wp/"))
  
    entries = doc.css('.article')
    @entriesArray = []
    entries.each do |entry|
      title = entry.css('h2').text #title "What's Going Here?"
      going_on_text = entry.css('p')[0].text #going on paragraph
      meant_text = entry.css('p')[1].text #what does this mean? paragraph
      care_text = entry.css('p')[2].text #why should I care? paragraph
      bigger_picture_text = entry.css('p')[3].text #the bigger picture paragraph
      publish_date = entry.css('time').text
      @entriesArray << Entry.new(title, going_on_text, meant_text, care_text, bigger_picture_text, publish_date)
      Post.create(title: title, going_on_text: going_on_text, meant_text: meant_text, care_text: care_text, bigger_picture_text: bigger_picture_text, publish_date: publish_date)
    end

    # We'll just try to render the array and see what happens
    render template: 'scrape_finimize'
  end
end
