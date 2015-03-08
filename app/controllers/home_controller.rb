class HomeController < ApplicationController

  def index
    PageView.create(url: '/home/index') 
    @home = Home.front
    #expires_in 5.minutes
    #fresh_when @home, public: true
    @content = FrontEndContent.get_content
  end
end
