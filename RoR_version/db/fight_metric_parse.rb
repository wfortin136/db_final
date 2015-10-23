require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://www.fightmetric.com/fight-details/2e47823d38a5649b"))
#output = page.css('body').css('section.b-fight-details__section js-fight-section')
output = page.css('body').css('section.b-statistics__section').css('div.l-page__container').css('div.b-fight-details').css('section')#.b-fight-details__section js-fight-section')

test = page.css('title')
puts test

output[2].css('td').each_with_index do |stats,index|
  f1 = stats.css('p')[0].text
  f2 = stats.css('p')[1].text
  #puts "Round #{Integer(index/10)+1}: f1-#{f1} f2-#{f2}" 
end
