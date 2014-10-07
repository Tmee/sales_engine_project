
module Repository

  def all(filename)
    @all ||=
  end

  def random
    @all.sample
  end

  def find_by_x(match)

  end

  def find_all_by_x(match)

  end

end