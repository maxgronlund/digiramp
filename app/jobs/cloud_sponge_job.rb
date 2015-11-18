

class CloudSpongeJob < ActiveJob::Base
  queue_as :default

  def perform user

    #'fo'
    #contacts = []
    #importer = Cloudsponge::ContactImporter.new('G7S7LV43UV4TUV4PD7XS', 'Ls6aU1SjZngnSlL4')
    #resp = importer.begin_import('gmail')
    ##puts "Navigate to #{resp[:consent_url]} and complete the authentication process."
    #user.set_go_to resp
    #loop do
    #  events = importer.get_events
    #  break unless events.select{ |e| e.is_error? }.empty?
    #  unless events.select{ |e| e.is_complete? }.empty?
    #    contacts = importer.get_contacts
    #    #contacts
    #    contacts[0].each do |contact|
    #      ap '---------------------'
    #      ap contact.emails
    #    end
    #    break
    #  end
    #  # be nice and take a short break
    #  sleep 1
    #end
     # contacts
    
  end
  
end
