require "selenium-webdriver"
require "har"
require "fileutils"


profile = Selenium::WebDriver::Firefox::Profile.new

profile.add_extension File.expand_path("../extensions/firebug-1.6.2.xpi", __FILE__)

profile['extensions.firebug.currentVersion'] = "1.6.2" # avoid 'first run' tab
profile["extensions.firebug.previousPlacement"] = 1
profile["extensions.firebug.onByDefault"] = true
profile["extensions.firebug.defaultPanelName"] = "net"
profile["extensions.firebug.net.enableSites"] = true
profile["extensions.firebug.allPagesActivation"] = "on"

profile.add_extension File.expand_path("../extensions/fireStarter-0.1.a5.xpi", __FILE__)
profile.add_extension File.expand_path("../extensions/netExport-0.8b8.xpi", __FILE__)

profile["extensions.firebug.netexport.alwaysEnableAutoExport"] = true
profile["extensions.firebug.netexport.autoExportToFile"] = true
profile["extensions.firebug.netexport.defaultLogDir"] = File.expand_path("../output_dir/", __FILE__)



driver = Selenium::WebDriver.for :firefox , :profile => profile
driver.get "http://www.sharecare.com"

wait = Selenium::WebDriver::Wait.new(:timeout => 5)

ask_text = wait.until {
  element = driver.find_element(:name => "query")
  element if element.displayed?
}

ask_text.clear
ask_text.send_keys "chickenpox"


ask_button = driver.find_element(:class => "ask")

ask_button.click


sleep(10)
driver.quit

=begin
look in output_dir for new .har file
put/read contents of .har
move .har to archive folder
=end


p HAR::Archive.from_file(File.expand_path("../output_dir/www.sharecare.com+2011-06-20+17-31-08.har", __FILE__)).to_json


#puts Dir.entries("../output_dir/").grep(/\.har/)
#p File.expand_path("../output_dir/#{Dir.glob("*.har")}", __FILE__)

=begin
counter = 1
file = File.new("../output_dir/*.har", "r")
while (line = file.gets)
  puts "#{counter}: #{line}"
  counter = counter + 1
end
file.close
=end


