class Invoice

  def initialize

  end

  def build_attendee(row)
  Attendee.new(:id          => row[:id],
               :customer_id => row[:customer_id],
               :merchant_id => row[:merchant_id],
               :status      => row[:status],
               :created_at  => row[:created_at],
               :updated_at  => row[:updated_at])
  end

end