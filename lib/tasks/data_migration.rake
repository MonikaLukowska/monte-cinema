require_relative '../../db/data_migrations/update_users_confirmed_at'

namespace :data_migration do
  desc 'Update existing users confirmed at'
  task update_users_confirmed_at: :environment do
    puts '--- Start updating users ---'

    ActiveRecord::Base.transaction do
      User.all.each do |user|
        user.update!(confirmed_at: DateTime.now)
      end
    rescue StandardError => e
      puts e.message
    end

    puts '--- Users updated ---'
  end
end
