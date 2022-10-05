namespace :data_migration do
  desc 'Update existing users confirmed at'
  task update_users_confirmed_at: :environment do
    puts '--- Start updating users ---'

    User.update_all(confirmed_at: DateTime.now)

    puts '--- Users updated ---'
  end
end
