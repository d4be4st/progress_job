# ProgressJob

This gem add a couple of colums to delayed job table, and gives u a basic class for working with progress

## Installation

You need to have https://github.com/collectiveidea/delayed_job in you gem file

Add this line to your application's Gemfile:

    gem 'progress_job'

And then execute:

    $ bundle

Run generator (run delayed job generators first!)

    $ rake progress_job:install

## Usage

Create a new class that extends ProgressJob::Base

    class NewJob < ProgressJob::Base

      def perform
        10.times do |i|
          sleep(1.seconds)
          update_progress(step: 10)
        end
      end

    end

Inside perform method you can use 'update_progress(step)' method to update the job progress.

To create a new job use Delayed job enqueue method, and pass the progress_max value

    job = Delayed::Job.enqueue NewJob.new(100)

There is also a controller which returns the delayed job with calculated percentage

    GET 'progress-jobs/:job_id/'

## Ajax usage

Example of ajax calls:

    $('.button').click(function(){

      var interval;
      $.ajax({
        url: '/start',
        success: function(job){
          interval = setInterval(function(){
            $.ajax({
              url: '/progress-jobs/' + job.id,
              success: function(job){
                $('.progress-bar').css('width', job.progress + '%').text(job.progress + '%')
              },
              error: function(){
                $('.progress-bar').css('width', '100%').text('100%')
                clearInterval(interval);
              }
            })
          },1000)
        }
      });
    });


## Contributing

1. Fork it ( http://github.com/<my-github-username>/progress_job/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
