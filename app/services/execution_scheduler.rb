class ExecutionScheduler
  attr_reader :automation, :config

  def initialize(automation:)
    @automation = automation
    @config = automation.configuration
  end

  def set_next_execution
    automation.update(next_execution: next_execution)
  end

  private

  def next_execution
    interval = config.range_amount.public_send(config.base.to_sym)
    result = automation.next_execution.to_date.in interval
    return evaluate_exceptions(result) if config.config_exceptions.one?
    
    (config.config_exceptions.count - 1).times { result = evaluate_exceptions(result) } unless config.config_exceptions.empty?

    result
  end

  def evaluate_exceptions(date)
    result = date.to_date
    config.config_exceptions.each do |exception|
      case exception.value
        when *Date::DAYNAMES
          result = result.next if result.public_send("#{exception.value.downcase}?".to_sym)
        when 'Weekend'
          result = result.next_week if result.on_weekend?
        when *Date::MONTHNAMES.compact
          result = result.next_month if Date::MONTHNAMES[date.month] == exception.value
        else
          raise "Invalid value for config_exceptions value '#{exception.value}'."
        end
    end

    result
  end
end
