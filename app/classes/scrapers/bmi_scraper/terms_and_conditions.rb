module Scraper::BmiScraper::TermsAndConditions
  def accept_terms_and_conditions
    if @page.title.downcase.include? "conditions"
      submit_button = @page.form.buttons.find{|b|b.value.downcase.include? "accept"}
      @page = @page.form.submit(submit_button) if submit_button
    end
  end
end