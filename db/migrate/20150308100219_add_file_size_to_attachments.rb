class AddFileSizeToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :file_size, :string, default: ''
    add_column :attachments, :content_type, :string, default: ''
  end
end
