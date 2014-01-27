class Ascap::WorksPage
  def Ascap::WorksPage browser
    browser.img(:id, 'btn_view_accepted_works').parent.click
  end
end