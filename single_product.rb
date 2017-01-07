require 'mechanize'
require 'uri'

# Print image links, price, and stock info to console.

#the following code searched the following DOM
# <div id="item_img">
# <a href="JavaScript:imageview('18693.jpg')">
# <img src="/imges/site/186932.jpg" border="0" width="500" height="500" alt="コスプレ Tバック k4428"><br><br>
# </a>
# <br><br>
#   <img src="/imges/site/18693_1.jpg"><br><br>
#   <img src="/imges/site/18693_2.jpg"><br><br>
#   <img src="/imges/site/18693_3.jpg"><br><br>
# </div>

baseURI = 'http://notarealsite.com/'
agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
page = agent.get ('http://notarealsite.com/details/18693/')
nodes = page.search "#item_img img" # this returns each node tagged 'img' under the id #item_img
nodes.each do |n|
  puts URI.join(baseURI, n.attributes['src'])
end
# this returns the numbers under the class 'item-zaiko', and gives stock
puts "Remaining stock " << page.at('.item-stock').text.match(/\d+/)[0]
# this gives the price
puts page.at('.red').text.lines.first.strip
