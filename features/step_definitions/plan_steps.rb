
Given(/^there is an plan named "(.*?)"$/) do |name|
  find_or_create_plan( name)
end

