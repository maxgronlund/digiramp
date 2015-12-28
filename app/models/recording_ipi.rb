class RecordingIpi < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :recording
  belongs_to :distribution_agreement
  validates :email, :role, :share, presence: true
  validates_formatting_of :email
  
  enum status: [ :pending, :confirmed, :accepted, :dismissed, :in_progress ]
  
  ROLES  = [ 
    "Artist",
    "Performers",
    "Producer",
    "Executive Producer",
    "Arranger",
    "Mixer",
    "Musician",
    "Vocalist",
    "Orchestrator",
    "Engineer",
    "Labels",
    "Production Companies",
    "Recording Studio",
    "Other"
  ]

  after_commit :flush_cache

  has_many :user_credits, as: :ipiable, dependent: :destroy
  #before_create :add_uuid
  #after_create :attach_user_credits
  #after_update :attach_user_credits
  #before_destroy :remove_user_credits
  
  # !!! self.recording.title is not a good ide
  #def attach_user_credits
  #  #if self.user
  #  #  UserCredit
  #  #  .where(ipiable_type: self.class.name, ipiable_id: self.id, user_id: self.user_id)
  #  #  .first_or_create(title: self.recording.title, 
  #  #                   ipiable_type: self.class.name, 
  #  #                   ipiable_id: self.id, 
  #  #                   user_id: self.user_id
  #  #                   )
  #  #end
  #  
  #end
  
  def create_stake shop_product, price_minus_labels_cut
    
    Notifyer.print( 'RecordingIpi#create_stake' , {price_minus_labels_cut: price_minus_labels_cut, recording_uuid: recording.uuid} ) if Rails.env.development?
    
    return unless self.user # !!! make gracefull error handling here 
    
    begin
      amount_in_cent =  price_minus_labels_cut  * self.share * 0.01
      amount_in_pct  = amount_in_cent / shop_product.price
      
      stake = Stake.create(  
        account_id:          self.account_id,
           user_id:             self.user_id,
           asset_id:            recording.uuid,
           asset_type:          'Recording',
           ip_uuid:             self.uuid,
           ip_type:             self.class.name,
           split:               amount_in_pct,
           flat_rate_in_cent:   amount_in_cent.round,
           currency:            'usd',
           email:               self.user.email,
           unassigned:          false,
           expired:             false,
           shop_product_id:     shop_product.id,
           description:         "Contributor: #{self.role}",
           shop_product_id:     shop_product.id
        )
    rescue => e
      ErrorNotification.post_object 'RecordingIpi#create_stake', e
    end
  end
  
  def update_stake shop_product, price_minus_labels_cut
     Notifyer.print( 'RecordingIpi#create_stake' , {price_minus_labels_cut: price_minus_labels_cut, recording_uuid: recording.uuid} ) if Rails.env.development?
    
     return unless self.user # !!! make gracefull error handling here 
    
     begin
       amount_in_cent =  price_minus_labels_cut  * self.share * 0.01
       amount_in_pct  = amount_in_cent / shop_product.price
      
       if stake = Stake.find_by(  
           account_id:          self.account_id,
           user_id:             self.user_id,
           asset_id:            recording.uuid,
           asset_type:          'Recording',
           ip_uuid:             self.uuid,
           ip_type:             self.class.name,
           #shop_product_id:     shop_product.id,
        
        )
        stake.update_columns(  
           split:               amount_in_pct,
           flat_rate_in_cent:   amount_in_cent.round,
           currency:            'usd',
           email:               self.user.email,
           shop_product_id:     shop_product.id,
           description:         "Contributor: #{self.role}"
        )
       else
         stake = Stake.create(  
            account_id:          self.account_id,
            user_id:             self.user_id,
            asset_id:            recording.uuid,
            asset_type:          'Recording',
            ip_uuid:             self.uuid,
            ip_type:             self.class.name,
            unassigned:          false,
            expired:             false,
            shop_product_id:     shop_product.id, 
            split:               amount_in_pct,
            flat_rate_in_cent:   amount_in_cent.round,
            currency:            'usd',
            email:               self.user.email,
            description:         "Contributor: #{self.role}",
            shop_product_id:     shop_product.id
         )
       end
     rescue => e
       ErrorNotification.post_object 'RecordingIpi#update_stake', e
     end
  end


  
  #def remove_user_credits
  #  begin
  #    UserCredit.where( ipiable_id: self.id, ipiable_type: self.class.name).destroy_all
  #  rescue
  #  end
  #end
  
  def full_name
    if self.user
      user.full_name
    else
      self.name
    end
  end
  
  def document_count
    0
  end
  
  #def add_uuid
  #  self.uuid = UUIDTools::UUID.timestamp_create().to_s
  #end
  #
  #def attach_user
  #  if user         = User.where(email: self.email).first
  #    self.user_id = user.id
  #    self.name    = user.user_name
  #  end
  #end
  
  def send_confirmation_request
    send_confirmation_email
    send_confirmation_notification
  end
  
  def self.cached_find(id)
    begin
      return Rails.cache.fetch([name, id]) { find(id) }
    rescue 
      return nil
    end
  end
  
  
  
private

  def send_confirmation_email
    RecordingIpiMailer.delay.recording_ipi_confirmation_email self.id
  end
  
  def send_confirmation_notification
    # if self.user
    #'send_confirmation_notification'
  end


  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end




