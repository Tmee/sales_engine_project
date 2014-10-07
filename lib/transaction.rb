class Transaction

  def initialize
  end

  def build_attendee(row)
  Attendee.new(:id                           => row[:id],
               :invoice_id                   => row[:invoice_id],
               :credit_card_number           => row[:credit_card_number],
               :credit_card_exporation_date  => row[:credit_card_exporation_date]
               :result                       => row[:result],
               :created_at                   => row[:created_at],
               :updated_at                   => row[:updated_at])
  end