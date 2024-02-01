namespace :db do
  desc 'Delete all records from all tables'
  task delete_all_records: :environment do
    if Rails.env.development? || Rails.env.test?
      # Get a list of all table names in the database
      key_tables = %w[activity_participants activities currencies accounts]
      table_names = ActiveRecord::Base.connection.tables.reject {|t| t.starts_with? 'good_job'} - key_tables - %w[schema_migrations ar_internal_metadata]

      table_names.each do |table_name|
        model = table_name.classify.safe_constantize
        next unless model&.table_exists?

        puts "Deleting records from #{table_name}..."
        model.delete_all
      end

      puts 'Deleting records from KEY tables'
      key_tables.each do |table_name|
        model = table_name.classify.safe_constantize
        next unless model&.table_exists?

        model.delete_all
      end

      # Delete credentials file
      credentials_file_path = Rails.root.join('data', 'credentials.yml')
      if File.exist?(credentials_file_path)
        File.delete(credentials_file_path)
        puts "Deleted credentials file at #{credentials_file_path}"
      end
    else
      puts 'This task can only be run in development or test environments.'
    end
  end
end
