module ProgressJob
  class Base
    def initialize(progress_max: 100)
      @progress_max = progress_max
    end

    def before(job)
      @job = job
      job.update_column(:progress_max, @progress_max)
      job.update_column(:progress_current, 0)
    end

    def update_progress(step: 1)
      @job.update_column(:progress_current, @job.progress_current + step)
    end

    def update_stage(stage)
      @job.update_column(:progress_stage, stage)
    end

    def update_stage_progress(stage, step: 1)
      update_stage(stage)
      update_progress(step: step)
    end

    def update_progress_max(progress_max)
      @job.update_column(:progress_max, progress_max)
    end

    def error(job, exception)
      job.update_column(:progress_stage, exception.message)
    end
  end
end
