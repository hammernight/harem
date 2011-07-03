require "watir-webdriver"

browser = Watir::Browser.new(:remote, :url => 'http://127.0.0.1:4444/wd/hub')
browser.goto "gridinit.com"

#browser.title.text.include? "Gridinit"


