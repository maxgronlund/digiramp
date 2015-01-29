class ClientLinkedinImportWorker
  include Sidekiq::Worker
  
  def perform( client_import_id, email )

    Client.import_clients_from_linkedin client_import_id
    Client.post_info(  email )
    #client_import = ClientImport.cached_find(client_import_id)
    #client_import.invite_clients
  end
end