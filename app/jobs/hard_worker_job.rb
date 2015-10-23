class HardWorkerJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    Rails.logger.info("user: #{user.id}")
    Rails.logger.info("starting hard work...")
    sleep(3)
    Rails.logger.info("ending hard work...")
  end

end
