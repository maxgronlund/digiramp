class ClientCsvImportWorker
  include Sidekiq::Worker
  
  def perform( client_import_id )
    puts '---------------------'
    puts client_import_id
    puts '---------------------'
    Client.import_clients_from client_import_id
  end
end