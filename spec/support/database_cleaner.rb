DatabaseCleaner[:active_record].strategy = :truncation

module Cleaner
  def self.clean
    clean_mysql
    clean_es
  end

  def self.clean_mysql
    ActiveRecord::Base.logger.silence { DatabaseCleaner[:active_record].clean }
  end

  def self.clean_es
    Rails.logger.silence do
      [PurchaseOrder].each do |cls|
        cls.__elasticsearch__.create_index! force: true
        cls.__elasticsearch__.refresh_index!
      end
    end
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:all, :sequential) do
    Cleaner.clean
  end

  config.around do |ex|
    unless ex.metadata[:sequential]
      Cleaner.clean_mysql unless ex.metadata[:no_db] || ex.metadata[:no_mysql]
      Cleaner.clean_es if ex.metadata[:es]
    end

    ex.run
  end
end
