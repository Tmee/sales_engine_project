class Test

  def initialize
    @data = data
  end

  def read_file
    @data = CSV.read('merchants.csv', headers: true, header_converters: :symbol)
    puts 'data'
  end
end