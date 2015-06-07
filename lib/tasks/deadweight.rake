# usage
# $ rails s
# in another terminal 
# $ rake deadweight

begin
  require 'deadweight'
rescue LoadError
end

# outcomment from bootstrap.css
# a[href^="#"]:after,
# a[href^="javascript:"]:after {
#   content: "";
# }

desc "run Deadweight (requires script/server)"
task :deadweight do
  dw = Deadweight.new
  
  #dw.ignore_selectors = /a[href^="#"]:after|flash_error|errorExplanation|fieldWithErrors/
  
  
  dw.stylesheets = ['/assets/application.css']
  dw.pages = ['/']
  puts dw.run
end