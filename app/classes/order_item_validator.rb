class OrderItemValidator < ActiveModel::Validator
  def validate(record)

    if record.quantity < 0
      record.errors[:quantity] << "Quantity can't be less than 1"
    end

  end
end