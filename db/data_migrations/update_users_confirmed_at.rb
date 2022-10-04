module DataMigrations
  CommitForbidden = Class.new(StandardError)
  class UpdateUsersConfirmedAt
    def self.call
      ActiveRecord::Base.transaction do
        User.all.each do |user|
          user.update!(confirmed_at: DateTime.now)
        end
      rescue StandardError => e
        puts e.message
      end
    end
  end
end
