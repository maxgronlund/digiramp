class AddPaymentToMusicRequests < ActiveRecord::Migration
  def change
    add_column :music_requests, :payment, :string
    
    MusicRequest.find_each do |music_request|
      music_request.payment = music_request.fee.to_s
      music_request.save! :validate => false

    end
    remove_column :music_requests, :fee
    rename_column :music_requests, :payment, :fee
  end
end
