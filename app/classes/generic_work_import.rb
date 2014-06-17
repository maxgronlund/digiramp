class GenericWorkImport
  def start import_id
    @import_class = self.class.class_variable_get(:@@import_class).call
    Rails.logger.info "Starting #{@import_class} #{import_id} import"
    @errors = {general_errors: [], work_creation_error: []}
    
    @notification_event = NotificationEvent.create
    
    begin      
      open_import import_id # must come first here
      puts "\n\n@import.params:\n\n\n#{@import.params}\n\n"
      @params = JSON.parse @import.params
      puts "@import.params parsed!\n\n #{@params.inspect}\n\n"
      
      @account = Account.find @import.account_id
      progress_notification title: "Work import in progress", body: "This will take ten to sixty minutes.", notification_event_id: @notification_event.id
      do_import
    ensure
      close_import
    end    
    
  end
  
  protected
  
  def open_import import_id
    @import = @import_class.find(import_id)
    @import.in_progress = true
    @import.total_works = 0
    @import.processed_works = 0
    @import.imported_works  = 0
    @import.updated_works   = 0
    @import.save
  end
  
  def progress_notification options
    return unless @account
    @progress_notification.delete if @progress_notification
    @progress_notification = @account.notifications.create options
    channel = {channel: "/accounts/#{@import.account_id}"}
    notification = @progress_notification.to_hash
    MessageWorker.perform_async channel.merge(notification)
  end
  
  def close_import
    @notification_event.delete
    @import.in_progress = false
    @import.save
    imported_works_notification @import.imported_works.to_i, @import.updated_works.to_i
    Rails.logger.info "#{@import_class} #{@import.id} closed!"
  end
  
  def imported_works_notification amount_imported, amount_updated
    if amount_imported > 0 && amount_updated > 0
      successful_import_and_update_notification amount_imported, amount_updated
    else
      if amount_imported > 0
        successful_import_notification amount_imported
      end
    
      if amount_updated > 0
        successful_update_notification amount_updated
      end
    end
        
    if amount_imported < 1 && amount_updated < 1
      if @import.processed_works > 0
        no_works_imported_notification @import.processed_works
      else
        no_works_found_notification
      end
    end
  end
  
  def no_works_found_notification
    progress_notification title: "No works found in '#{@import.title}'",
                          body: "Search criteria didn't yield any results.",
                          sticky: true,
                          notification_type: "warning"
  end
  
  def no_works_imported_notification processed_works
    progress_notification title: "No works imported in '#{@import.title}'",
                          body: "Processed #{"work".en.plural(amount)} but no works was imported. The works might already be in DigiRAMP.",
                          sticky: true,
                          notification_type: "info"
  end
  
  def successful_import_notification amount
    progress_notification title: import_title(amount),
                          body: import_body(amount),
                          sticky: true,
                          notification_type: "success"
  end
  
  def successful_update_notification amount
    progress_notification title: update_title(amount),
                          body: update_body(amount),
                          sticky: true,
                          notification_type: "success"
  end
  
  def successful_import_and_update_notification amount_imported, amount_updated
    progress_notification title: import_and_update_title(amount_imported, amount_updated),
                          body: import_and_update_body(amount_imported, amount_updated),
                          sticky: true,
                          notification_type: "success"
  end
  
  def import_title amount
    "#{"work".en.quantify(amount).capitalize} #{"has been".en.plural(amount)} imported in '#{@import.title}'"
  end
  
  def import_body amount
    "An import of #{amount} #{"work".en.plural(amount)} has finished. Go to common works page."
  end
  
  def update_title amount
    "#{"work".en.quantify(amount).capitalize} #{"has been".en.plural(amount)} updated in '#{@import.title}'"
  end
  
  def update_body amount
    "An update of #{amount} #{"work".en.plural(amount)} has finished. Go to common works page."
  end
  
  def import_and_update_title amount_imported, amount_updated
    import_title(amount_imported) + " and #{"work".en.quantify(amount_updated)} #{"has been".en.plural(amount_updated)} updated"
  end
  
  def import_and_update_body amount_imported, amount_updated
    "An import of #{amount_imported} #{"work".en.plural(amount_imported)} and update of #{amount_updated} #{"work".en.plural(amount_updated)} has finished. Check out the works on the import page and on the common works page."
  end
  
  def import_update_notification
    body = ""
    if @import.total_works && @import.total_works > 0 && @import.processed_works
      body = "Processed #{((@import.processed_works.to_f/@import.total_works)*99.99).floor}% of #{"work".en.quantify(@import.total_works)}."
    end
    if @import.imported_works > 0 && @import.updated_works > 0
      body << " Currently #{@import.imported_works} #{"work".en.plural(@import.imported_works)} #{"has ben".en.plural(@import.imported_works)} imported and #{@import.updated_works} #{"work".en.plural(@import.updated_works)} #{"has ben".en.plural(@import.updated_works)} updated."
    else 
      body << " Currently #{@import.imported_works} #{"work".en.plural(@import.imported_works)} #{"has ben".en.plural(@import.imported_works)} imported." if @import.imported_works > 0
      body << " Currently #{@import.updated_works} #{"work".en.plural(@import.updated_works)} #{"has ben".en.plural(@import.updated_works)} updated." if @import.updated_works > 0
    end
    progress_notification title: "Work import '#{@import.title}' in progress", body: body.strip, notification_event_id: @notification_event.id, sticky: true
  end
  
  #def display_errors
  #  n = @errors[:general_errors].length + @errors[:work_creation_error].length
  #  @errors[:general_errors].each do |error|
  #    warn error.message
  #    warn error.backtrace
  #    warn "\n\n\n"
  #    warn error.message.to_s
  #    warn error.backtrace.to_s
  #  end
  #  @errors[:work_creation_error].each do |error|
  #    p error.message
  #    p error.backtrace
  #    p "\n\n\n"
  #    p error.message.to_s
  #    p error.backtrace.to_s
  #  end
  #  raise "#{n} errors while importing from #{@import_class}! #{@errors}" if n > 0
  #end
end