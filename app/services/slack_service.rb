class SlackService
  def self.user_signed_up user
    
    begin
      notifier = Slack::Notifier.new 'https://hooks.slack.com/services/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'
      notifier.ping "SUCCESS #{user.user_name} just signed up"
    rescue
    end
    
    
    #if ENV['SLACK_WEBHOOK']
    #  notifier = Slack::Notifier.new 'https://hooks.slack.com/services/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'
    #  notifier.ping message
    #else
    #  puts message
    #end
  end
  
  def self.contact_request_received
    
    begin
      notifier = Slack::Notifier.new 'https://hooks.slack.com/services/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'
      notifier.ping "Contact request receives"
    rescue
    end
    
    
    #if ENV['SLACK_WEBHOOK']
    #  notifier = Slack::Notifier.new 'https://hooks.slack.com/services/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'
    #  notifier.ping message
    #else
    #  puts message
    #end
  end
end

# SlackService.notify message