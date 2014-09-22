module ProgressJob
  class ProgressController < ActionController::Base

    respond_to :json

    def show
      @current_job = Delayed::Job.find(params[:job_id])
      percentage = current_job.current_progress / current_job.max_progress.to_f * 100
      @current_job[:percentage] = percentage
      render json: @current_job
    end

  end
end