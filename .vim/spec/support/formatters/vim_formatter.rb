# frozen_string_literal: true

require 'rspec/core/formatters/base_text_formatter'

class VimFormatter < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register self, :example_failed
  RSpec.configuration.color_mode = :off

  MAX_SIZE = 80

  # def example_pending(notification); end
  #
  def dump_failures(notification)
    # output blank
  end

  # def dump_pending(notification); end

  def dump_summary(notification)
    # output blank
  end

  # def seed(notification); end
  #
  # def message(notification); end

  def example_failed(notification)
    output.puts "     #{format(notification.message_lines.join)}\n     # #{format notification.formatted_backtrace.join}"
  end

  private

  def format(msg)
    # msg.gsub("\n", ' ').gsub(/ {2,}/, ' ')[0..MAX_SIZE]
    msg.gsub("\n", ' ').gsub(/ {2,}/, ' ')
  end
end

a
