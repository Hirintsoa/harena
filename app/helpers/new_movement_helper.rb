module NewMovementHelper
  def holiday_select_tag
    <<~ERB
      <%= label_tag :holiday_exceptions, "Policy (#{Date.today.year} official infos)", class: ['required'] %>
      <%= select_tag(:holiday_exceptions,
                      options_for_select(Configuration::HOLIDAY_POLICY_COUNTRIES),
                      class: ['w-2/3', 'max-w-sm'],
                      required: true,
                      prompt: "Select value(s)") %>
    ERB
  end

  def day_select_tag
    <<~ERB
      <%= label_tag :day_exceptions, 'Day(s) exception', class: ['required'] %>
      <%= select_tag(:day_exceptions,
                      options_for_select(Date::DAYNAMES),
                      class: ['w-2/3', 'max-w-sm'],
                      required: true,
                      prompt: "Select value(s)") %>
    ERB
  end

  def month_select_tag
    <<~ERB
      <%= label_tag :month_exceptions, 'Month(s) exception', class: ['required'] %>
      <%= select_tag(:month_exceptions,
                      options_for_select(Date::MONTHNAMES.compact),
                      class: ['w-2/3', 'max-w-sm'],
                      required: true,
                      prompt: "Select value(s)") %>
    ERB
  end
end
