module NewMovementHelper
  def holiday_select_tag(id)
    <<~ERB
      <%= label_tag "exception_#{id}", "Policy (#{Date.today.year} official infos)", class: ['required'] %>
      <%= select_tag("exception_#{id}",
                      options_for_select(Configuration::HOLIDAY_POLICY_COUNTRIES),
                      class: ['w-2/3', 'max-w-sm'],
                      required: true) %>
    ERB
  end

  def day_select_tag(id)
    <<~ERB
      <%= label_tag "exception_#{id}", 'Exception', class: ['required'] %>
      <%= select_tag("exception_#{id}",
                      options_for_select(Date::DAYNAMES),
                      class: ['w-2/3', 'max-w-sm'],
                      required: true) %>
    ERB
  end

  def month_select_tag(id)
    <<~ERB
      <%= label_tag "exception_#{id}", 'Exception', class: ['required'] %>
      <%= select_tag("exception_#{id}",
                      options_for_select(Date::MONTHNAMES.compact),
                      class: ['w-2/3', 'max-w-sm'],
                      required: true) %>
    ERB
  end
end
