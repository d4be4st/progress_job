Rails.application.routes.draw do
  get 'progress-job/:job_id' => 'progress_job/progress#show'
end