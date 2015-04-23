module ProgressJob
  class ProgressController < ActionController::Base

    def show
      @delayed_job = Delayed::Job.find_by(id: params[:job_id])
      if @delayed_job
        percentage = !@delayed_job.progress_max.zero? ? @delayed_job.progress_current / @delayed_job.progress_max.to_f * 100 : 0
        render json: @delayed_job.attributes.merge!(percentage: percentage).to_json
      else
        render json: {job_not_found: true}.to_json
      end
    end

  end
end
