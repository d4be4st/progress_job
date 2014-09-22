module ProgressJob
  class Base
    def initialize(progress_max)
      @progress_max = progress_max
      super()
    end

    def before(job)
      @job = job
      @job.update_column(:progress_max, @progress_max)
    end

    def update_progress(step: 1)
      @job.update_column(:progress_current, @job.progress_current + step)
    end
  end
end