# usage
# $ rails s
# in another terminal 
# $ rake deadweight

begin
  require 'deadweight'
  require 'awesome_print'
rescue LoadError
end

# outcomment from bootstrap.css
# a[href^="#"]:after,
# a[href^="javascript:"]:after {
#   content: "";
# }

desc "run Deadweight (requires script/server)"
task :deadweight do
  ap '=================='
  dw = Deadweight.new
  dw.mechanize = true

  
  dw.pages << proc {
    fetch('/login/new')
    login_form              = agent.page.forms.first
    login_form['sessions[email]']     = 'max@digiramp.com'
    login_form['sessions[password]']  = 'rosalina'
    agent.submit(login_form, login_form.buttons.first)
   
    
    
  }
  dw.stylesheets = ['/assets/application.css']
  dw.pages = ['/users/max-groenlund/edit']
  ap dw
  ap '=============================='
  ap dw.run
  
  
  #dw.ignore_selectors = /a[href^="#"]:after|flash_error|errorExplanation|fieldWithErrors/
  
  
  #dw.stylesheets = ['/assets/application.css']
  #puts dw.run
  #dw.pages = ['/', 
  #            #'/users/max-groenlund',
  #            '/users/max-groenlund/edit'
  #            #'/users/max-groenlund/followers?clear=clear',
  #            #'/users/max-groenlund/following?clear=clear',
  #            #'/songs?clear=clear',
  #            #'/users?clear=clear',
  #            #'/users/max-groenlund/unread_messages',
  #            #'/users/max-groenlund/received_messages',
  #            #'/users/max-groenlund/send_messages',
  #            #'/users/max-groenlund/messages',
  #            #'/user/users/max-groenlund/connections',
  #            #'/users/max-groenlund/messages?connection_id=2265',
  #            #'/users/max-groenlund/recordings/1355',
  #            #'/users/max-groenlund/recording_basics/1355/edit',
  #            #'/users/max-groenlund/recording_lyrics/1355/edit',
  #            #'/users/max-groenlund/recording_tags/1355/edit',
  #            #'/user/users/max-groenlund/common_works/8933?recording_id=1355',
  #            #'/user/users/max-groenlund/common_works/8933/edit',
  #            #'/user/users/max-groenlund/common_works/8933/ipis/new',
  #            #'/users/max-groenlund/recordings/1355/recording_likes',
  #            #'/users/max-groenlund/recordings/1355/recording_playbacks',
  #            #'/users/max-groenlund/likes',
  #            #'/users/max-groenlund/playlists',
  #            #'/users/max-groenlund/playlists/338',
  #            #'/user/users/max-groenlund/playlists/338/edit',
  #            #'/user/users/max-groenlund/playlists/338/playlist_emails/new',
  #            #'/users/max-groenlund/ipis',
  #            #'/user/users/max-groenlund/control_panel',
  #            #'/user/users/max-groenlund/contacts',
  #            #'/user/users/max-groenlund/contacts/80254',
  #            #'/user/users/max-groenlund/contacts/80254/edit',
  #            #'/user/users/max-groenlund/contact_groups',
  #            #'/user/users/max-groenlund/contact_groups/4',
  #            #'/user/users/max-groenlund/contact_groups/4/edit',
  #            #'/user/users/max-groenlund/contacts/new'
  #          ]
 #puts dw.run
end