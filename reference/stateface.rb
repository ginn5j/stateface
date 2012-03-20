require 'rubygems'
require 'erb'
require 'json'
require 'tilt'

STATES = [
  ["Alabama", "AL", "Ala.", 1, "B"],
  ["Alaska", "AK", "Alaska", 2, "A"],
  ["Arizona", "AZ", "Ariz.", 4, "D"],
  ["Arkansas", "AR", "Ark.", 5, "C"],
  ["California", "CA", "Calif.", 6, "E"],
  ["Colorado", "CO", "Colo.", 8, "F"],
  ["Connecticut", "CT", "Conn.", 9, "G"],
  ["Delaware", "DE", "Del.", "10", "H"],
  ["District of Columbia", "DC", "D.C.", 11, "y"],
  ["Florida", "FL", "Fla.", 12, "I"],
  ["Georgia", "GA", "Ga.", 13, "J"],
  ["Hawaii", "HI", "Hawaii", 15, "K"],
  ["Idaho", "ID", "Idaho", 16, "M"],
  ["Illinois", "IL", "Ill.", 17, "N"],
  ["Indiana", "IN", "Ind.", 18, "O"],
  ["Iowa", "IA", "Iowa", 19, "L"],
  ["Kansas", "KS", "Kan.", 20, "P"],
  ["Kentucky", "KY", "Ky.", 21, "Q"],
  ["Louisiana", "LA", "La.", 22, "R"],
  ["Maine", "ME", "Maine", 23, "U"],
  ["Maryland", "MD", "Md.", 24, "T"],
  ["Massachusetts", "MA", "Mass.", 25, "S"],
  ["Michigan", "MI", "Mich.", 26, "V"],
  ["Minnesota", "MN", "Minn.", 27, "W"],
  ["Mississippi", "MS", "Miss.", 28, "Y"],
  ["Missouri", "MO", "Mo.", 29, "X"],
  ["Montana", "MT", "Mont.", 30, "Z"],
  ["Nebraska", "NE", "Neb.", 31, "c"],
  ["Nevada", "NV", "Nev.", 32, "g"],
  ["New Hampshire", "NH", "N.H.", 33, "d"],
  ["New Jersey", "NJ", "N.J.", 34, "e"],
  ["New Mexico", "NM", "N.M.", 35, "f"],
  ["New York", "NY", "N.Y.", 36, "h"],
  ["North Carolina", "NC", "N.C.", 37, "a"],
  ["North Dakota", "ND", "N.D.", 38, "b"],
  ["Ohio", "OH", "Ohio", 39, "i"],
  ["Oklahoma", "OK", "Okla.", 40, "j"],
  ["Oregon", "OR", "Ore.", 41, "k"],
  ["Pennsylvania", "PA", "Pa.", 42, "l"],
  ["Rhode Island", "RI", "R.I.", 44, "m"],
  ["South Carolina", "SC", "S.C.", 45, "n"],
  ["South Dakota", "SD", "S.D.", 46, "o"],
  ["Tennessee", "TN", "Tenn.", 47, "p"],
  ["Texas", "TX", "Texas", 48, "q"],
  ["Utah", "UT", "Utah", 49, "r"],
  ["Vermont", "VT", "Vt.", 50, "t"],
  ["Virginia", "VA", "Va.", 51, "s"],
  ["Washington", "WA", "Wash.", 53, "u"],
  ["West Virginia", "WV", "W.Va.", 54, "w"],
  ["Wisconsin", "WI", "Wis.", 55, "v"],
  ["Wyoming", "WY", "Wyo.", 56, "x"],
  ["United States", "US", "U.S.", nil, "z"]
]

state_characters = {}
STATES.each { |s| state_characters[s[1]] = s[4] }

template = %q{
<html>
<head><title>StateFace</title>
<style>
@font-face {
    font-family: 'StateFaceRegular';
    src: url('font/webfont/stateface-regular-webfont.eot');
    src: url('font/webfont/stateface-regular-webfont.eot?#iefix') format('embedded-opentype'),
         url('font/webfont/stateface-regular-webfont.woff') format('woff'),
         url('font/webfont/stateface-regular-webfont.ttf') format('truetype'),
         url('font/webfont/stateface-regular-webfont.svg#StateFaceRegular') format('svg');
    font-weight: normal;
    font-style: normal;
}
body { font-size: 16px; font-family: Helvetica, Arial, sans-serif; width: 960px; margin: 10px auto; }
div { clear:both; height: 500px; margin-bottom: 30px;}
td#minimap { width: 15px;}
table { font-size: 16px; width: 200px ; margin: 10px 0; float: left; margin-right: 40px; }
table.StateFace td { border-bottom: 1px silver solid; padding: 5px; }
#minimap { font-family: 'StateFaceRegular'; text-align: center; vertical-align: top;}
</style>
</head>
<body>
<%= Tilt.new('../README.md').render %>
<h2>StateFace Keyboard Map</h2>
<div><table class="StateFace">
<% STATES.sort.each_with_index do |state,idx| %>
<tr><td id="minimap"><%= state[4] %></td><td><%= state[2] %></td><td><%= state[4] %></td></tr>
<% if [13,27,41].include?(idx) %>
</table><table class="StateFace">
<% end %>
<% end %>
</table></div>
<div><h2>JSON (Postal, Key)</h2><pre><%= JSON.pretty_generate(state_characters) %></pre></div>
</body></html>
}.gsub(/^  /, '')

File.open('../index.html', 'w') do |f|
  f.write ERB.new(template).result
end

File.open('stateface.json', 'w') do |f|
  f.write ERB.new(JSON.pretty_generate(state_characters)).result
end


