class FollowUpEmailJob < ActiveJob::Base
  ############################
  # Standard ActiveJob stuff #
  ############################
  queue_as :email

  def perform(email)
    puts "Making attempt number #{@attempt_number}"
    # When this is 5 or greater it will get run 5 times and then fail
    # when this is less than 5 the job will raise that many times, be retried,
    # and then succeed
    raise "Oh no" unless @attempt_number > 4
    UserMailer.follow_up_email(email).deliver_now
  end

  ##############
  # Retry code #
  ##############
  rescue_from(Exception) { |ex| retry_or_raise(ex) }

  def backoff_strategy
    [0, 3, 5, 10, 15].freeze
  end

  def max_attempts
    backoff_strategy.length
  end

  def retry_or_raise(exception)
    raise exception if @attempt_number >= max_attempts
    puts "Retrying in #{backoff_strategy[@attempt_number]}"
    retry_job(wait: backoff_strategy[@attempt_number])
  end

  def serialize
    super.merge('attempt_number' => (@attempt_number || 0) + 1)
  end

  def deserialize(job_data)
    super(job_data)
    self.attempt_number = job_data['attempt_number']
  end

  attr_accessor :attempt_number
end
