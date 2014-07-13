class Client < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :client_groups
  before_create :set_user_uuid
  
  
  include PgSearch
  pg_search_scope :search, against: [ :name,         
                                      :last_name,    
                                      :title,    
                                      :telephone_home,
                                      :business_phone,
                                      :business_fax, 
                                      :fax_home,     
                                      :cell_phone,   
                                      :company,      
                                      :capacity,     
                                      :address_home, 
                                      :address_work, 
                                      :city_work,    
                                      :state_work,   
                                      :zip_work,     
                                      :country_work, 
                                      :email,        
                                      :home_page,    
                                      :department,     
                                      :assistant,    
                                      :direct_phone, 
                                      :direct_fax,   
                                      :business_email 
                                      ], :using => [:tsearch]
  
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
        client   = Client.where(email: client_info["Email"], account_id:  client_import.account_id ).first_or_create(email: client_info["Email"])
        
        
        
        client.name                = client_info["Name"]             if client_info["Name"]              
        client.last_name           = client_info["Last Name"]        if client_info["Last Name"]
        client.company             = client_info["Company"]          if client_info["Company"]
        client.email               = client_info["Email"]            if client_info["Email"]
        client.assistant           = client_info["Assistant"]        if client_info["Assistant"]
        client.direct_phone        = client_info["Direct Phone"]     if client_info["Direct Phone"]
        client.direct_fax          = client_info["Direct Fax"]       if client_info["Direct Fax"]
        client.capacity            = client_info["Capacity"]         if client_info["Capacity"]
        client.address_work        = client_info["Address"]          if client_info["Address"]
        client.city_work           = client_info["City"]             if client_info["City"]
        client.state_work          = client_info["State"]            if client_info["State"]
        client.zip_work            = client_info["Zip"]              if client_info["Zip"]
        client.country_work        = client_info["Country"]          if client_info["Country"]
        client.home_page           = client_info["Home Page"]        if client_info["Home Page"]
        client.business_phone      = client_info["Business Phone"]   if client_info["Business Phone"]
        client.business_fax        = client_info["Bus. Fax"]         if client_info["Bus. Fax"]
        client.business_email      = client_info["Bus. Email"]       if client_info["Bus. Email"]
        
        client.account_id          = client_import.account_id
        client.save!
      end

      
    end

  end
  
  
end






