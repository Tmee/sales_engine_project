class InvoiceItem

  def initialize
  end

  def build_attendee(row)
  Attendee.new(:id         => row[:id],
               :item_id    => row[:name],
               :invoice_id => row[:invoice_id],
               :quantity   => row[:quantity],
               :unit_price => row[:unit_price],
               :created_at => row[:created_at],
               :updated_at => row[:updated_at])
  end