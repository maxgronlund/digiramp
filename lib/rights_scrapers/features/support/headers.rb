module Headers
  def get_headers_for table
    if table.match /table:Work title,BMI Work ID,ISWC,Registration Date/
      return {
        /Work title/        => :work_title,
        /BMI Work ID/       => :bmi_work_id,
        /ISWC/              => :iswc,
        /Registration Date/ => :registration_date
      }
    else
      return {
        /Work title/        => :work_title,
        /Ascap Work ID/     => :ascap_work_id,
        /Duration/          => :duration,
        /ISWC/              => :iswc,
        /Genre/             => :genre,
        /Registration Date/ => :registration_date,
        /Intended Purpose/  => :intended_purpose,
        /Alternate Titles/  => :alternate_titles,
        /Recording's Album Title/ => :album_title,
        /Performers/        => :performers
      }
    end
    #raise "Undefined headers for table:\n  #{table}"
  end
end

World(Headers)