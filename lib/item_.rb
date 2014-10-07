class Item

  def initialize

  end

  def build_attendee(row)
  Attendee.new(:id           => row[:id],
               :name         => row[:name],
               :description  => row[:description],
               :unit_price   => row[:unit_price],
               :merchant_id  => row[:merchant_id],
               :created_at   => row[:created_at],
               :updated_at   => row[:updated_at])
  end

end