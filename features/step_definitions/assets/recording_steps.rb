Given(/^these recordings$/) do |recordings_table|
  create_recordings recordings_table.raw
end