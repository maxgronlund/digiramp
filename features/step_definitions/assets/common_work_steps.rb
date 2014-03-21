Given(/^these common works:$/) do |common_works_table|
  # table is a Cucumber::Ast::Table

  create_common_works common_works_table.raw
end