require 'open-uri'
require 'Nokogiri'
require 'Pry'

doc = Nokogiri::HTML(open('https://www.rbi.org.in/scripts/bs_viewcontent.aspx?Id=2009'))

doc.css('#example-min table table td:nth-child(2) a').each do |content|
  begin
    download_link = content.attributes["href"].value.gsub(/^http:\/\//i, 'https://');
    filename = download_link.to_s.split('/')[-1]
    download_file = open(download_link)
    IO.copy_stream(download_file, filename)
    puts "downloaded - #{filename}"    
  rescue => exception
    puts "Failed to download with exception - #{exception}  --- download-link #{download_link}" 
  end
end
