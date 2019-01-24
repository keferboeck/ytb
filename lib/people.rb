require 'haversine'

class People
  InvalidRadius = Class.new(StandardError)
  InvalidColumn = Class.new(StandardError)
  InvalidCollection = Class.new(StandardError)

  attr_reader :coordinates

  def initialize(people: [], coordinates: {:latitude => 51.450167, :longitude => -2.594678})
    validate_people(people)

    @people = people
    @coordinates = coordinates.values
  end

  def filter_by_radius(radius:)
    validate_radius(radius)

    @people = @people.select do |person|
      (Haversine.distance(coordinates, [person["location"]["latitude"].to_f,
                                        person["location"]["longitude"].to_f]).to_km <= radius.to_i)
    end
    self
  end

  def filter_by_column(column:, value:)
    validate_column(column)

    @people = @people.select do |person|
      (person[column].downcase == value.downcase)
    end
    self
  end

  def sort_by(column:)
    validate_column(column)

    begin
      @people = @people.sort_by { |person| person[column] }
      @people.reverse
    rescue
      puts "====> sort_by failed"
    end
  end

  def avg(column:)
    validate_column(column)

    @people = @people.inject(0) do |sum, hash|
      sum + hash[column].to_f
    end.fdiv(@people.size)
  end

  def to_a
    @people.to_a
  end

  private
    def validate_radius(radius)
      raise(InvalidRadius, radius) unless radius.instance_of?(Integer) && radius.to_i > 0
    end

    def validate_column(column)
      raise(InvalidColumn, column) unless @people.first.key?(column) if @people.size > 0
    end

    def validate_people(people)
      raise(InvalidCollection) unless !people.nil? && people.size > 0 && people[0]["location"].key?("latitude") && people[0]["location"].key?("longitude")
    end
end