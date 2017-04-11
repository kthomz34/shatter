class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def scrape_reddit
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.reddit.com/"))
    render text: doc
  end
end
