class Instruction < ActiveRecord::Base
  
  def self.introduction
    Instruction.where(identifier: 'introduction').first_or_create(identifier: 'introduction', title: 'Introduction to DigiRAMP')
  end
end
