class Client < ActiveRecord::Base
  belongs_to :account
  before_create :set_user_uuid
  
  
  include PgSearch
  pg_search_scope :search, against: [ :title, 
                                      :name, 
                                      :last_name, 
                                      :telephone_home, 
                                      :telephone_work,
                                      :address_home,
                                      :address_work,
                                      :email ], :using => [:tsearch]
  
  def set_user_uuid
    self.user_uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  def self.account_search(account, query)
    clients = account.clients
    if query.present?
     clients = clients.search(query)
    end
    clients
  end
  
  def full_name
    self.name + ' ' + self.last_name
  end
  
  def self.post_info user_email

    channel = 'digiramp_radio_' + user_email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'CSV file imported', 
                                          "message" => "Please reload the client page", 
                                          "time"    => '5000', 
                                          "sticky"  => 'false', 
                                          "image"   => 'success'
                                          })

  end
  
  # called from a worker
  def self.import_clients_from client_import_id
    
    client_import                = ClientImport.find(client_import_id)


    CSV.foreach(client_import.file.path, headers: true) do |row|
      #Product.create! row.to_hash
      client_info                 =  row.to_hash
      
      ap client_info

      if client_info["Email"].to_s != ''
        client   = Client.where(email: client_info["Email"] ).first_or_create(email: client_info["Email"])
        
        
        
        client.name                = client_info["Name"]
        client.last_name           = client_info["Last Name"]
        client.title               = client_info["Name"]
        client.photo               = client_info["Name"]
        client.telephone_home      = client_info["Name"]
        client.telephone_work      = client_info["Direct Phone"]
        client.fax_work            = client_info["Direct Fax"]
        client.fax_home            = client_info["Name"]
        client.cell_phone          = client_info["Name"]
        client.company             = client_info["Company"]
        client.capacity            = client_info["Capacity"]
        client.address_home        = client_info["Name"]
        client.address_work        = client_info["Address"]
        client.city_work           = client_info["City"]
        client.state_work          = client_info["State"]
        client.zip_work            = client_info["Zip"]
        client.country_work        = client_info["Name"]
        client.email               = client_info["Email"]
        client.home_page           = client_info["Home Page"]
        
        client.account_id          = client_import.account_id
        client.save!
      end

      
    end

  end
  
  
end






