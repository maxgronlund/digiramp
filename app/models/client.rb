# encoding: UTF-8

class Client < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :client_import
  has_and_belongs_to_many :client_groups
  has_many :playlist_key_users
  before_create :set_user_uuid
  after_create :conect_to_user
  after_commit :flush_cache
  before_save :set_full_name
  validates_presence_of :email
  
  
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
  
  def user_name
    
  end
  
  def member
    # optimization: avoid db lookup
    if self.member_id
      begin
        return User.cached_find(self.member_id)
      rescue
        return nil
      end
    end
    nil
  end
  
  
  
  def set_full_name
    self.full_name = self.name + ' ' + self.last_name
  end
  
  def conect_to_user
    if user = User.where(email: self.email).first
      self.member_id = user.id
      self.save!
      true
    else
      false
    end
  end
  
  def self.group_search( clients,  query)
    
    if query.present?
     clients = clients.search(query)
    end
    clients
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
  

  
  
  def self.import_clients_from_linkedin client_import_id
    return unless client_import  = ClientImport.find_by(id: client_import_id)
    return unless content        = File.read(client_import.file.path)

    detection                    = CharlockHolmes::EncodingDetector.detect(client_import.file.path)
    utf8_encoded_content         = CharlockHolmes::Converter.convert content, detection[:encoding], 'UTF-8'
    tempfile                     = Tempfile.new("linked_in_client_import#{client_import_id}")
    
    begin
      tempfile.write(utf8_encoded_content)
      tempfile.rewind
      begin
        CSV.foreach(tempfile.path, headers: true, :encoding => 'ISO-8859-1') do |row|  

          client_info                 =  row.to_hash
          if client_info["E-mail Address"].to_s != ''
            client  = Client.where( email: client_info["E-mail Address"], 
                                    account_id:  client_import.account_id )
                            .first_or_create(email: client_info["E-mail Address"])
        
            client.client_import_id    = client_import_id
            client.name                = client_info["First Name"]            if client_info["First Name"].to_s                            != ""            
            client.last_name           = client_info["Last Name"]             if client_info["Last Name"].to_s                             != ""   
            client.company             = client_info["Company"]               if client_info["Company"].to_s                               != ""   
            client.assistant           = client_info["Assistant's Name"]      if client_info["Assistant's Name"].to_s                      != ""  
            client.telephone_home      = client_info["Home Phone"]            if client_info["Home Phone"].to_s                            != ""  
            client.direct_phone        = client_info["Direct Phone"]          if client_info["Primary Phone"].to_s                         != ""  
            client.direct_fax          = client_info["Business Fax"]          if client_info["Business Fax"].to_s                          != ""  
            client.address_work        = client_info["Business Street"]       if client_info["Business Street"].to_s                       != "" 
            client.state_work          = client_info["Business State"]        if client_info["Business State"].to_s                        != "" 
            client.zip_work            = client_info["Business Postal Code"]  if client_info["Business Postal Code"].to_s                  != "" 
            client.country_work        = client_info["Business Country"]      if client_info["Business Country"].to_s                      != "" 
            client.capacity            = client_info["Job Title"]             if client_info["Job Title"].to_s                             != ""  
            client.address_work        = client_info["Address"]               if client_info["Address"].to_s                               != ""  
            client.city_work           = client_info["City"]                  if client_info["City"].to_s                                  != ""  
            client.state_work          = client_info["State"]                 if client_info["State"].to_s                                 != ""  
            client.zip_work            = client_info["Zip"]                   if client_info["Zip"].to_s                                   != ""  
            client.country_work        = client_info["Country"]               if client_info["Country"].to_s                               != ""  
            client.home_page           = client_info["Home Page"]             if client_info["Home Page"].to_s                             != ""  
            client.business_phone      = client_info["Business Phone"]        if client_info["Business Phone"].to_s                        != ""  
            client.business_fax        = client_info["Business Fax"]          if client_info["Business Fax"].to_s                          != ""  
            client.home_page           = client_info["Web Page"]              if client_info["Web Page"].to_s                              != "" 
            client.department          = client_info["Department"]            if client_info["Department"].to_s                            != ""  
            client.assistant           = client_info["Assistant's Name"]      if client_info["Assistant's Name"].to_s                      != ""  
            client.account_id          = client_import.account_id
            client.user_id             = client_import.user_id
            client.save!
          end
        end
      rescue
        return
      end
    ensure
      tempfile.close
      tempfile.unlink
    end
  end
  
  # called from a worker
  def self.import_clients_from client_import_id
    return unless client_import   = ClientImport.find_by(id: client_import_id)
    return unless content         = File.read(client_import.file.path)
    detection               = CharlockHolmes::EncodingDetector.detect(client_import.file.path)
    utf8_encoded_content    = CharlockHolmes::Converter.convert content, detection[:encoding], 'UTF-8'
    tempfile = Tempfile.new("linked_in_client_import#{client_import_id}")
    begin
      tempfile.write(utf8_encoded_content)
      tempfile.rewind
      begin
        CSV.foreach(tempfile.path, headers: true, :encoding => 'ISO-8859-1') do |row|  
        
          client_info                 =  row.to_hash
        
          if client_info["Email"].nil?
            client_info["Email"] = client_info["E-mail Address"] unless client_info["E-mail Address"].nil?
          end 
          
          if client_info["Email"].nil?
            client_info["Email"] = client_info["Bus. Email"] unless client_info["Bus. Email"].nil?
          end 
          
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
            client.user_id             = client_import.account.user_id
            client.account_id          = client_import.account_id
            client.save!
          end
        end
      rescue
        return
      end
    ensure
      tempfile.close
      tempfile.unlink
    end
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
  
end






