#https://github.com/cloudsponge/cloudsponge-lib-ruby

class CloudContacts
  


  def self.process
    ap 'fo'
   contacts = nil
   importer = Cloudsponge::ContactImporter.new('G7S7LV43UV4TUV4PD7XS', 'Ls6aU1SjZngnSlL4')
   resp = importer.begin_import('linkedin')
   puts "Navigate to #{resp[:consent_url]} and complete the authentication process."
   loop do
     events = importer.get_events
     break unless events.select{ |e| e.is_error? }.empty?
     unless events.select{ |e| e.is_complete? }.empty?
       contacts = importer.get_contacts
       ap contacts
       break
     end
     # be nice and take a short break
     
     sleep 1
   end
    ap contacts
    
    
  end


end