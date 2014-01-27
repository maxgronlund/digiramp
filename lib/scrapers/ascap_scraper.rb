require './lib/scrapers/scraper'
module Scraper::AscapScraper
  require_relative 'ascap_scraper/search'
  require_relative 'ascap_scraper/ascap_iswc'
  require_relative 'ascap_scraper/ascap_ipi'
  require_relative 'ascap_scraper/import'
end