require 'nokogiri'
require 'open-uri'
require 'pry'

URLS = {
    USER_AGENT: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2",
    }
def run_scraper
   @url = 'https://www.ncbi.nlm.nih.gov/pubmed?term=((%22body%20packing%22%5BMeSH%20Terms%5D%20OR%20(%22body%22%5BAll%20Fields%5D%20AND%20%22packing%22%5BAll%20Fields%5D)%20OR%20%22body%20packing%22%5BAll%20Fields%5D)%20AND%20(%22cocaine%22%5BMeSH%20Terms%5D%20OR%20%22cocaine%22%5BAll%20Fields%5D)%20AND%20%22loattrfree%20full%20text%22%5Bsb%5D)'
   result_page = Nokogiri::HTML(open("#{@url}", 'User-Agent' => URLS[:USER_AGENT]), nil, "UTF-8").css('div.content div.rprt')

   papers_hash = {}
   result_page.each do |item|
     @number = item.css("div.rprtnum.nohighlight span").text
     @name = item.css("div.rslt p.title").text
     @authors = item.css("div.rslt div.supp p.desc").text
     @journal = item.css("div.rslt div.supp p.details span.jrnl[title]").text
     @doi = item.css("div.rslt div.supp p.details span.jrnl")
     @link = item.css("div.rslt p.title a[href]").text

    #  each_paper = Nokogiri::HTML(open("#{@link}", 'User-Agent' => URLS[:USER_AGENT]), nil, "UTF-8")

     papers_hash[@number.to_sym] = {
       name: @name,
       authors: @authors,
       journal: @journal,
       doi: @doi,
       link: @link
       }
    end 
    papers_hash
end 