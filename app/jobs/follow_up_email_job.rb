class FollowUpEmailJob < ActiveJob::Base
  ##############
  # Retry code #
  ##############
  include ActiveJob::Retry
  retry_with limit: 5, delay: 3

  ############################
  # Standard ActiveJob stuff #
  ############################
  queue_as :email

  def perform(email)
    puts "Making attempt number #{retry_attempt}"
    # When this is 5 or greater it will get run 5 times and then fail
    # when this is less than 5 the job will raise that many times, be retried,
    # and then succeed
    raise "Oh no" unless retry_attempt > 4
    UserMailer.follow_up_email(email).deliver_now
  end
end
