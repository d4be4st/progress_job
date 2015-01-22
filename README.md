# ProgressJob

This gem add a couple of colums to delayed job table, and gives u a basic class for working with progress

![progress_job](https://s3.amazonaws.com/infinum.web.production/repository_items/files/000/000/435/original/progress_job.gif?1414140810)

## Installation

You need to have https://github.com/collectiveidea/delayed_job in you gem file

Add this line to your application's Gemfile:

    gem 'progress_job'

And then execute:

    $ bundle

Run generator (run delayed job generators first!)

    $ rails generate progress_job:install

## Usage

Create a new class that extends ProgressJob::Base

    class NewJob < ProgressJob::Base

      def perform
        # some actions
      end

    end

Inside perform method you can use:

    update_progress(step: 10) # default step is 1
    update_stage('name of stage')
    update_stage_progress('name of stage', step: 11)
    update_progress_max(progress_max)

methods to update the job progress.


To create a new job use Delayed job enqueue method, and pass the progress_max value

    job = Delayed::Job.enqueue NewJob.new(progress_max: 100) # default progress_max is 100

There is also a controller which returns the delayed job with calculated percentage

    GET 'progress-jobs/:job_id/'

## Examples

### Progress job class

``` ruby
  class NewJob < ProgressJob::Base

    def perform
      handler = Handler.new

      update_stage('Handling ports')
      handler.handle_ports

      update_stage_progress('Handling cruise', step: 10)
      handler.handle_cruise

      update_stage_progress('Handling days', step: 10)
      handler.handle_days

      update_stage_progress('Handling pick up times', step: 10)
      handler.handle_pick_up_times

      update_stage_progress('Handling users', step: 10)
      handler.handle_users

      update_stage_progress('Handling item categories', step: 10)
      handler.handle_item_categories

      update_stage_progress('Handling items', step: 10)
      handler.handle_items
      handler.handle_other_items

      update_stage_progress('Handling event types', step: 10)
      handler.handle_event_types

      update_stage_progress('Handling events', step: 10)
      handler.handle_events
    end

  end
```

### HAML 

``` ruby
  = simple_form_for :import, url: [:import], remote: true do |f|
    .row
      .col-xs-10
        = f.input :file, as: :file
      .col-xs-2
        = f.button :submit, "Import", class: "btn btn-success"

    %br
    .well{style: "display:none"}
      .row
        .col-xs-12
          .progress-status.text-primary
      .row
        .col-xs-12
          .progress.progress-striped.active
            .progress-bar
              .text-primary
                0%
```

### Ajax usage

Example of ajax call (this is a .html.haml remote: true response):

``` javascript
  var interval;
  $('.hermes-import .well').show();
  interval = setInterval(function(){
    $.ajax({
      url: '/progress-job/' + #{@job.id},
      success: function(job){
        var stage, progress;

        // If there are errors
        if (job.last_error != null) {
          $('.progress-status').addClass('text-danger').text(job.progress_stage);
          $('.progress-bar').addClass('progress-bar-danger');
          $('.progress').removeClass('active');
          clearInterval(interval);
        }

        // Upload stage
        if (job.progress_stage != null){
          stage = job.progress_stage;
          progress = job.progress_current / job.progress_max * 100;
        } else {
          progress = 0;
          stage = 'Uploading file';
        }

        // In job stage
        if (progress !== 0){
          $('.progress-bar').css('width', progress + '%').text(progress + '%');
        }

        $('.progress-status').text(stage);
      },
      error: function(){
        // Job is no loger in database which means it finished successfuly
        $('.progress').removeClass('active');
        $('.progress-bar').css('width', '100%').text('100%');
        $('.progress-status').text('Successfully imported!');
        clearInterval(interval);
      }
    })
  },100);
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/progress_job/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
