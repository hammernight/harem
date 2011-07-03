require "selenium-webdriver"


driver = Selenium::WebDriver.for :chrome
driver.get "http://www.sharecare.com"

wait = Selenium::WebDriver::Wait.new(:timeout => 5)

ask_text = wait.until {
  element = driver.find_element(:name => "query")
  element if element.displayed?
}

ask_button = wait.until {
  element = driver.find_element(:class => "ask")
  element if element.displayed?
}

ask_text.clear
ask_text.send_keys "chickenpox"
ask_button.click

search_results_bar = wait.until {
  element = driver.find_element(:class => "hl-title")
  element if element.displayed?
}

p search_results_bar




# puts "WebTimings: "
# p driver.execute_script("return window.performance || window.webkitPerformance || window.mozPerformance || window.msPerformance;")

sleep(10)

p search_results_bar
driver.quit
