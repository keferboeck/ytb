require 'terminal-table'

class Interface
  attr_reader :title

  def print_table(collection: [], headings: [])
    collection = verify_array(collection)
    headings = verify_array(headings)

    rows = []
    collection.each do |element|
      columns = get_hash_values(element, headings)
      rows << columns
    end
    puts Terminal::Table.new :headings => headings, :rows => rows
  end

  def print_value(value: 0, heading:)
    puts Terminal::Table.new { |row| row << [heading, value]}
  end

  private
    def verify_array(array)
      return array if array.is_a? Array
      return []
    end

    def get_hash_values(h,headings)
      h.each_with_object([]) do |(k,v),keys|
        keys << v if headings.include? k.to_sym
        keys.concat(get_hash_values(v, headings)) if v.is_a? Hash
      end
    end
end

