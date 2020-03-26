# frozen_string_literal: true

require 'rspec/core/formatters/base_text_formatter'

class VimFormatter < RSpec::Core::Formatters::BaseTextFormatter
  def example_failed(example)
    exception = example.execution_result[:exception]
    path = Regexp.last_match(1) if exception.backtrace.find do |frame|
      frame =~ %r{\b(spec/.*_spec\.rb:\d+)(?::|\z)}
    end
    message = format_message exception.message
    path    = format_caller path
    if path
      output.puts "#{path}: #{example.example_group.description.strip} " \
                  "#{example.description.strip}: #{message.strip}"
    end
  end

  def example_pending(*args); end

  def dump_failures(*args); end

  def dump_pending(*args); end

  def message(msg); end

  def dump_summary(*args); end

  def seed(*args); end

  private

  def format_message(msg)
    msg.gsub("\n", ' ')[0, 80]
  end
end
