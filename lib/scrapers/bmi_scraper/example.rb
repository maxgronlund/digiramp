__END__
#require_relative '../scraper'
#require_relative 'writer/writer_list'
#require_relative 'writer/writer_works'
#require_relative 'work'

writers = WriterList['trent buck']
works = WriterWorks[writers.first[:url]]
work = Work[works.first[:url]]

puts "Work number: #{work[:work_number]}"
puts "Work title: #{work[:title]}"

work[:writers].each do |writer|
  puts "----- Writer:    -----"
  p writer
end
work[:publishers].each do |publisher|
  puts "----- Publisher: -----"
  p publisher
end
