# recordings can be 
# public
# private
# users can have permission to 
# CRUD audio
# CRUD recording/info
# CRUD common work
# CRUD artwork
# CRUD documents
# CRUD IPI'S
# CRUD legal documents
# CRUD financial documents





class ExportPermissionKeysToRecordings < ActiveRecord::Migration
  def up
    
    #manager_ids                     = []
    #create_recordings_ids           = []
    #read_recordings_ids             = []
    #update_recordings_ids           = []
    #delete_recordings_ids           = []
    #create_ipi_ids                  = []
    #read_ipi_ids                    = []
    #update_ipi_ids                  = []
    #delete_ipi_ids                  = []
    #create_common_work_ids          = []
    #read_common_work_ids            = []
    #update_common_work_ids          = []
    #delete_common_work_ids          = []
    #create_artwork_ids              = []
    #read_artwork_ids                = []
    #update_artwork_ids              = []
    #delete_artwork_ids              = []
    #create_documents_ids            = []
    #read_documents_ids              = []
    #update_documents_ids            = []
    #delete_documents_ids            = []
    #create_legal_documents_ids      = []
    #read_legal_documents_ids        = []
    #update_legal_documents_ids      = []
    #delete_legal_documents_ids      = []
    #create_financial_documents_ids  = []
    #read_financial_documents_ids    = []
    #update_financial_documents_ids  = []
    #delete_financial_documents_ids  = []
    #
    #
    #
    #
    #
    #permission_keys = {  public: false, 
    #                    manager_ids:                      manager_ids,
    #                    create_recordings_ids:            create_recordings_ids,
    #                    read_recordings_ids:              read_recordings_ids,
    #                    update_recordings_ids:             update_recordings_ids,
    #                    delete_recordings_ids:            delete_recordings_ids,
    #                    create_ipi_ids:                   create_ipi_ids,
    #                    read_ipi_ids:                     read_ipi_ids,
    #                    update_ipi_ids:                   update_ipi_ids,
    #                    delete_ipi_ids:                   delete_ipi_ids,
    #                    create_common_work_ids:           create_common_work_ids,
    #                    read_common_work_ids:             read_common_work_ids,
    #                    update_common_work_ids:           update_common_work_ids,
    #                    delete_common_work_ids:           delete_common_work_ids,
    #                    create_artwork_ids:               create_artwork_ids,
    #                    read_artwork_ids:                 read_artwork_ids,
    #                    update_artwork_ids:               update_artwork_ids,
    #                    delete_artwork_ids:               delete_artwork_ids,
    #                    create_documents_ids:             create_documents_ids,
    #                    read_documents_ids:               read_documents_ids,
    #                    update_documents_ids:             update_documents_ids,
    #                    delete_documents_ids:             delete_documents_ids,
    #                    create_legal_documents_ids:       create_legal_documents_ids,
    #                    read_legal_documents_ids:         read_legal_documents_ids,
    #                    update_legal_documents_ids:       update_legal_documents_ids,
    #                    delete_legal_documents_ids:       delete_legal_documents_ids,
    #                    create_financial_documents_ids:   create_financial_documents_ids,
    #                    read_financial_documents_ids:     read_financial_documents_ids,
    #                    update_financial_documents_ids:   update_financial_documents_ids,
    #                    delete_financial_documents_ids:   delete_financial_documents_ids
    #                  
    #                  }
    #                  
   #Recording.all.each do |recording|
   #  recording.permission_keys = permission_keys
   #  recording.save!
   #end
    
   #CatalogUser.all.each do |catalog_user|
   #  
   #  catalog = catalog_user.catalog
   #  
   #  if recordings = catalog.catalog_items.where(catalog_itemable_type: 'Recording')
   #  
   #    recordings.each do |recording|
   #      permission_keys = recording.permission_keys[:manager_ids] << [1,3,4]
   #      
   #    end
   #  end
   #  
   #end
  end
  
  def down
    
  end
end
