require "rspec"
require "spec_helper"
require "selenium-webdriver"
require "capybara"
require "capybara/rspec"



describe "Search Sarecare" do

  it "should go to the sharecare site and perform a search" do

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

    puts "WebTimings: "
    p driver.execute_script("return window.performance || window.webkitPerformance || window.mozPerformance || window.msPerformance;")

    sleep(10)

    search_results_bar = wait.until {
      element = driver.find_element(:class => "hl-title")
      element if element.displayed?
    }

    #search_results_bar.should have_content("chickenpox")
    driver.quit


  end
end

