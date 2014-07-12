class ClientCsvImportWorker
  include Sidekiq::Worker
  
  def perform( client_import_id, email )

    Client.import_clients_from client_import_id
    Client.post_info(  email )
  end
end