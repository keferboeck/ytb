require_relative '../lib/task.rb'

def process_arguments(args)
  arguments = {}
  args.each_with_index do |val, index|
    case val
    when "-radius"
      arguments.merge!(:filter_by_radius => {:radius => args[index + 1]})
    when "-sort_by"
      arguments.merge!(:sort_by => {:value => args[index + 1]})
    when "-filter_by"
      arguments.merge!(:filter_by_column => {:column => args[index + 1] ,:value => args[index + 2]})
    end
  end
  return arguments
end

task = Task.new

if ARGV.any?
  case ARGV[0]
  when "-l"
    task.one
  when "-a"
    task.two
  when "-c"
    #ARGV.delete_at(0) unless ARGV.empty?
    arguments = process_arguments(ARGV)
    task.three(arguments)
  else
    task.manual
  end
else
  task.manual
end