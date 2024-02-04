FactoryBot.define do
  factory :config_exception do
    value { [ Date::DAYNAMES, Date::MONTHNAMES.compact ].flatten.sample }
    configuration
  end
end
