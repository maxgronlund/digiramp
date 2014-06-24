class AddSslUrlToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :ssl_url, :string                   , default: ""
    add_column :recordings, :url, :string                       , default: ""
    add_column :recordings, :ext, :string                       , default: ""
    add_column :recordings, :original_file_name, :string        , default: ""
    
    
  end
end
