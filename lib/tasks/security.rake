task :rails_best_practices do
  path = File.expand_path("../../../", __FILE__)
  sh "rails_best_practices #{path}"
end