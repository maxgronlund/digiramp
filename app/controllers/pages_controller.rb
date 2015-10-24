class PagesController < ApplicationController
  include HighVoltage::StaticPage
  
  layout :layout_for_page
  
  
  def down_for_maintenance
   
  end
  
  private
  def layout_for_page
    case params[:id]
    when 'down_for_maintenance'
      'down_for_maintenance'
    else
      'application'
    end
  end
end
