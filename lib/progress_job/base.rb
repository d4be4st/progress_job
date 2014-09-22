module ProgressJob
  class Base
    def initialize(max_progress)
      @max_progress = max_progress
      super()
    end

    def before(job)
      @job = job
      @job.update_column(:max_progress, @max_progress)
    end

    def update_progress(step: 1)
      @job.update_column(:current_progress, @job.current_progress + step)
    end
  end
end