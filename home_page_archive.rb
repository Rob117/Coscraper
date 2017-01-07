require 'mechanize'
require 'uri'

# The following code searched the following DOM
# Only relevant sections included

# <div id="main"> == $0
# massive amounts of irrelevant stuff
# <a href="/details/18513/">
# <img src="/imges/site/185133.jpg" border="0" alt="コスプレ ランジェリー セクシー ベビードール スリップ 紫 v021 半額" width="160"></a>

baseURI = 'http://notarealsite.com/'
agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
page = agent.get(baseURI)
# this returns each node tagged 'img' under the id main
nodes = page.search '#main img'
nodes.each do |n|
  name_of_item =n.attributes['alt'].to_s
  # add the relative path in the src label to the base uri
  final = URI.join(baseURI, n.attributes['src'])
  # This saves the image on the hdd in a file
  agent.get(final).save "#{'notarealsite/' << name_of_item}" if final.to_s.include? 'imges/site'
  puts name_of_item
  #puts final.to_s.split('/').last # this is if you want to save it by id number.jpg
end
