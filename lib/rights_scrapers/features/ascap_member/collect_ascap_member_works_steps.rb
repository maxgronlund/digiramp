When(/^I collect the works from the Ascap member$/i) do  
  get_ascap_details unless $ascap_details
end

When(/^I have collected the works from the Ascap member$/i) do
  cached_ascap_details
end

Then(/^I should be able to find the work matching all these info:$/) do |table|
  table.map_headers(get_headers_for table).hashes.each do |row|
    raise "Title does not match"   unless $ascap_details.detect { |detail| detail[:title]         == row[:work_title]   }
    raise "Work ID does not match" unless $ascap_details.detect { |detail| detail[:ascap_work_id] == row[:ascap_work_id]}
    mismatch row, :album_title        unless is_a_match row, :recording_info, :album_title
    mismatch row, :genre              unless is_a_match row, :details, "Genre", :genre
    mismatch row, :registration_date  unless is_a_match row, :details, "Initial Registration Date", :registration_date
    mismatch row, :iswc               unless is_a_match row, :alternate_ids, "ISWC", :iswc
    mismatch row, :duration           unless is_a_match row, :recording_info, "Duration", :duration
    mismatch row, :intended_purpose   unless is_a_match row, :details, "Intended Purpose", :intended_purpose
    mismatch row, :alternate_titles   unless contains?  row, :alternate_titles
    mismatch row, :performers         unless contains?  row, :performers
  end
end

Given(/^the Ascap Work ID (\d+)$/i) do |ascap_work_id|
  @ascap_work_id = ascap_work_id
end

Given(/^the IPI (\d+)$/) do |ipi_number|
  @ipi_number = ipi_number
end

Then(/^I should see:$/) do |table|
  headers = {
    /Ascap Work ID/ => :ascap_work_id,
    /Name/       => :full_name,
    /Role/       => :role,
    /Ipi Number/ => :ipi_number,
    /Society/    => :society,
    /Own/        => :own_percent,
    /Collect/    => :collect_percent,
    /Status/     => :status,
    /Agreement/  => :has_agreement
  }
  table.map_headers(headers).hashes.each do |row|
    work = $ascap_details.detect { |detail| detail[:ascap_work_id] == row[:ascap_work_id] }
    raise "Not a match" unless work && work[:ipis].detect do |ipi|
      status = ipi[:controlled_by_submitter] ? "Authoritative " : ""
      status += ipi[:linked_to_ascap_member] ? "Ascap Member" : "No Member ID"
      
      match = \
      row[:status]                    == status                       &&
      to_bool(row[:has_agreement])    == to_bool(ipi[:has_agreement]) &&
      row[:full_name]                 == ipi[:full_name]              &&
      row[:role]                      == ipi[:role]                   &&
      row[:society]                   == ipi[:society]                &&
      row[:own_percent].to_f          == ipi[:own_percent].to_f       &&
      row[:collect_percent].to_f      == ipi[:collect_percent].to_f
      match &&= row[:ipi_number].to_i == ipi[:ipi_number].to_i #unless row[:ipi_number].to_i == 0
      match
      
    end
  end
end