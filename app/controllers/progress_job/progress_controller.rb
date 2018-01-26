module ProgressJob
  class ProgressController < ActionController::Base

    def show
      @delayed_job = Delayed::Job.find(params[:job_id])
      return unless @delayed_job.present?
      percentage = !@delayed_job.progress_max.zero? ? @delayed_job.progress_current / @delayed_job.progress_max.to_f * 100 : 0
      render json: @delayed_job.attributes.merge!(percentage: percentage).to_json
    end

  end
end