require 'json'

class Reader
  InvalidFile = Class.new(StandardError)

  def self.import(path = "./assets/people.json")
    raise(InvalidFile, path) unless File.exist?(path)
    JSON.parse(File.read(path))
  end
end