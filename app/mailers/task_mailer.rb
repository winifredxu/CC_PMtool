class TaskMailer < ApplicationMailer
  def notify_task_owner (task, my_user)
    @task = task
    @my_user = my_user
    mail to: @task.user.email, subject: "You have a completed task!"   
  end

  def newly_created_tasks_daily_summary (project, daily_tasks) 
    @project = project
    @daily_tasks = daily_tasks
    mail to: @project.user.email, subject: "Your daily created tasks summary list!"
  end
end
