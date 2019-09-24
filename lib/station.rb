
class Station

  attr_reader :name, :zone

  def initialize(args)
    @name = args[:name]
    @zone = args[:zone]
  end

end
