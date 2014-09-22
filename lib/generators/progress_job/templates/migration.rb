class AddProgressToDelayedJobs < ActiveRecord::Migration
  def change
    change_table :delayed_jobs do |t|
      t.string :progress_stage, required: true
      t.string :progress_current, required: true, default: 0
      t.string :progress_max, required: true, default: 0
    end

  end
end