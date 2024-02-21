class Configuration < ApplicationRecord
  BASE_OPTIONS = %w[daily weekly fortnightly monthly quarterly custom].freeze

  EXCEPTION_OPTIONS = %w[weekend holiday day month].freeze

  COUNTRY_NAMES = {
    'US' => 'United States',
    'BR' => 'Brazil',
    'FR' => 'France',
    'UK' => 'United Kingdom',
    'SA' => 'Saudi Arabia',
    'IN' => 'India',
    'MG' => 'Madagascar',
    'JP' => 'Japan',
    'MA' => 'Morocco',
    'CI' => 'Ivory Coast'
  }.freeze
  
  HOLIDAY_POLICY_COUNTRIES = %w[US BR FR UK SA IN MG JP MA CI].map { |iso| [COUNTRY_NAMES[iso], iso] }.freeze

  has_many :config_exceptions
end
