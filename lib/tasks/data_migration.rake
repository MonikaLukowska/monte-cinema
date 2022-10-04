require_relative '../../db/data_migrations/update_users_confirmed_at'

namespace :data_migration do
  desc 'Update existing users confirmed at'
  task update_users_confirmed_at: :environment do
    DataMigrations::UpdateUsersConfirmedAt.call
  end
end
