work: 
	QUEUE=* bundle exec rake environment resque:work
scheduler:
	RESQUE_SCHEDULER_INTERVAL=0.5 bundle exec rake environment resque:scheduler
