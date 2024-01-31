require 'faker'

class FakerPopulator
  # include Auth::JsonWebToken
  def initialize
    @countries = YAML.load_file(Rails.root.join('data', 'currencies.yml'))
    @credentials = []
  end

  def call
    Faker::Number.between(from: 35, to: 60).times do |x|
      Faker::Company.unique.clear if (x % 15).zero?
      create_account
    end
    store_credentials

    ActiveRecord::Base.transaction do
      Faker::Number.between(from: (Account.count / 1.5).ceil, to: Account.count * 3).times do |x|
        Faker::Company.unique.clear if (x % 15).zero?
        append_participants(create_activity)
      end
    end
  end

  private

  def store_credentials
    File.open(Rails.root.join('data', 'credentials.yml'), 'w') do |file|
      YAML.dump(@credentials, file)
    end
  end

  def simulate_versions_usage(activity, date)
    activity.versions.last.update(created_at: date)
  end

  def create_account
    character = Faker::Movies::HarryPotter.unique.character
    lang = Faker::Address.country_code
    country = @countries.detect {|c| c['iso'] == lang}
    password = Faker::Internet.password
    new_account = Account.new(
      email: Faker::Internet.unique.email(name: character),
      password: password,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      country: country['name'],
      lang: lang,
      picture: Faker::Avatar.image(slug: character),
      mail_notifications: Faker::Boolean.boolean(true_ratio: 0.15)
    )
    new_account.save
    @credentials << { account: new_account.email, password: password }

    UserCurrency.create(
      account_id: Account.find(new_account.id).id,
      currency_id: Currency.find_by(country_code: lang)&.id || Currency.first.id,
      main: true
    )

    assign_activity(new_account)
  end

  def create_currencies
    @countries.map do |country|
      Currency.create(
        name: country['currency_name'],
        acronym: country['currency_code'],
        sign: country['sign'],
        country_code: country['iso'] || Faker::Address.country_code
      )
    end
  end

  def create_activity
    start_date = Faker::Date.backward(days: 50)
    new_activity = Activity.new(
      name: Faker::Company.unique.department,
      description: Faker::Company.catch_phrase,
      start_date: start_date,
      balance: Faker::Commerce.price(range: 500..30000.0),
    )
    new_activity.save

    Faker::Number.between(from: 5, to: 25).times { create_wish(new_activity) }

    new_activity
  end

  def assign_activity(account, activity = create_activity)
    ActivityParticipant.create(
      account_id: account.id,
      activity_id: activity.id
    )
  end

  def append_participants(activity)
    participants = []
    if activity.accounts.empty?
      return participants << Account.all.sample if Faker::Boolean.boolean(true_ratio: 0.35)

      Faker::Number.between(from: 2, to: 5).times do
        random_id = Account.ids[Faker::Number.between(from: 1, to: (Account.ids.size - 1))]
        participants << Account.find(random_id)
      end
    end

    participants.uniq.each do |participant|
      assign_activity(participant, activity)
    rescue ActiveModel::ValidationError
      next
    end
  end

  def create_income(activity)
    new_income = Income.create(
      name: [Faker::Company.department, "#{Faker::Company.profession} salary",
             Faker::Commerce.department(max: 2, fixed_amount: true)].sample,
      description: Faker::Company.catch_phrase,
      amount: Faker::Commerce.price(range: 2000..750_000.0),
      activity_id: activity.id,
      created_at: Faker::Date.between(from: activity.start_date, to: Date.today).to_datetime
    )
    activity.update(balance: activity.balance + amount)
    simulate_versions_usage(activity, new_income.created_at)
  end

  def create_expense(activity)
    new_expense = Expense.create(
      name: [Faker::Company.department, Faker::Commerce.product_name,
             Faker::Commerce.department(max: 2, fixed_amount: true)].sample,
      description: Faker::Company.catch_phrase,
      amount: Faker::Commerce.price(range: 100..7500.0),
      activity_id: activity.id,
      created_at: Faker::Date.between(from: activity.start_date, to: Date.today).to_datetime
    )
    activity.update(balance: activity.balance - new_expense.amount)
    simulate_versions_usage(activity, new_expense.created_at)
  end

  def create_wish(activity)
    Wish.create(
      name: [Faker::Company.name, Faker::Commerce.product_name].sample,
      description: Faker::Company.catch_phrase,
      estimation: (Faker::Commerce.price * [10, 20, 50, 100, 200].sample).round(2),
      priority: Faker::Number.between(from: 1, to: 5),
      activity_id: activity.id
    )
  end

  def days_of_week
    Date::DAYNAMES
  end

  def days_of_month
    (1..28).to_a.map { |day| format('%02d', day) }
  end

  def months_of_year
    Date::MONTHNAMES.compact
  end
end
