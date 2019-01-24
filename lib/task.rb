require_relative 'reader.rb'
require_relative 'people.rb'
require_relative 'interface.rb'

class Task
  def one
    list = people
               .filter_by_column(:column => "country", :value => "england")
               .filter_by_radius(:radius => 100)
               .sort_by(:column => "value")
    interface.print_table(:collection => list, :headings => [:id, :value, :first, :last, :email])
  end

  def two
    avg = people
              .filter_by_column(:column => "country", :value => "england")
              .filter_by_radius(:radius => 200)
              .avg(:column => "value")
    interface.print_value(:value => avg, :heading => "Average")
  end

  def three(args)
    list = people

    puts args.dig(:filter_by_radius, :radius)

    if args.has_key?(:filter_by_column)
      list = list.filter_by_column(:column => args.dig(:filter_by_column, :column), :value => args.dig(:filter_by_column, :value))
    end
    if args.has_key?(:filter_by_radius)
      list = list.filter_by_radius(:radius => args.dig(:filter_by_radius, :radius).to_i)
    end
    if args.has_key?(:sort_by)
      list = list.sort_by(:column => args.dig(:sort_by, :value))
    end

    interface.print_table(:collection => list.to_a, :headings => [:id, :value, :first, :last, :latitude, :longitude, :email, :country])
  end

  def manual
    puts "To run the first task:\n $ ruby bin/runner.rb -l\nTo run the second task:\n $ ruby bin/runner.rb -a"
  end

  private
    def people
      @people ||= People.new(:people => Reader.import)
    end

    def interface
      @interface ||= Interface.new
    end
end