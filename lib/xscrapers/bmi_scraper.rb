require './lib/scrapers/scraper'
module Scraper::BmiScraper
  require_relative 'bmi_scraper/terms_and_conditions'
  require_relative 'bmi_scraper/work'
  require_relative 'bmi_scraper/import'
  require_relative 'bmi_scraper/writer/writer_list'
end