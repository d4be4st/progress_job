Rails.application.routes.draw do
  get 'progress-job/progress' => 'progress_job/progress#progress'
end