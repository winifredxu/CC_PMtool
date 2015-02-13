class DiscussionMailer < ApplicationMailer
  def notify_discussion_owner (comment, my_user)
    @comment = comment
    @discussion = @comment.discussion
    @my_user = my_user
    mail to: @discussion.user.email, subject: "You've got a comment!"    
  end  

  def newly_created_discussions_daily_summary (project, daily_discussions)
    @project = project
    @daily_discussions = daily_discussions
    mail to: @project.user.email, subject: "Your daily created discussions summary list"
  end
end