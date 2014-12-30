# ActiveJob Retry test

`resque-retry` is really neat and I wanted to see how easy it would be to re-implement this generically  with Rails 4.2 ActiveJob. Turns out it's pretty easy. The meat is in [`FollowUpEmailJob`](https://github.com/isaacseymour/activejob-retry-test/blob/master/app/jobs/follow_up_email_job.rb).

## Running
```bash
gem install mailcatcher
mailcatcher # Teeny SMTP server to check that the job is sending emails

# Get everything installed and serving
bundle install
rackup

# Fire up Resque:
RESQUE_SCHEDULER_INTERVAL=0.5 rake resque:scheduler
QUEUE=* rake resque:work
```

Visit [http://localhost:9292/users/new](http://localhost:9292/users/new) and sign yourself up! You shouldn't need to `rake db:migrate` etc because the database is committed, it is only a test...

Mailcatcher shows its inbox on [1080](http://localhost:1080).
