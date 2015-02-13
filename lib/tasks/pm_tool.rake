namespace :pm_tool do
 
  desc "Generate a summary list of all newly created tasks that day for projects "
  task :list_tasks => :environment do
    Project.all.each do |p|
      @project = p
      @daily_tasks = p.tasks.where("created_at >= ?", Time.zone.now.beginning_of_day)
      #  Task.where("created_at >= ?", Time.now - 1.days)
      TaskMailer.newly_created_tasks_daily_summary(@project, @daily_tasks).deliver_later
    end
  end


  desc "Generate a summary list of all newly created discussions that day for projects"
  task :list_discussions => :environment do
    Project.all.each do |p|
      @project = p
      @daily_discussions = p.discussions.where("created_at >= ?", Time.zone.now.beginning_of_day)
#DEPRECATION WARNING: `#deliver` is deprecated and will be removed in Rails 5. Use `#deliver_now` to deliver immediately or `#deliver_later` to deliver through Active Job.
      DiscussionMailer.newly_created_discussions_daily_summary(@project, @daily_discussions).deliver_later
    end
  end
end
