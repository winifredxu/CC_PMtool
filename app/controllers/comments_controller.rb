class CommentsController < ApplicationController
	before_action :authenticate_user! 	
	before_action :find_discussion
	before_action :find_comment, only: [:update, :destroy]

	def create
		@comment = Comment.new comment_params
		@comment.discussion = @discussion

		respond_to do |format|		
			if @comment.save

				if @comment.user != @discussion.user

					# background email job, use deliver_later
#DEPRECATION WARNING: `#deliver` is deprecated and will be removed in Rails 5. Use `#deliver_now` to deliver immediately or `#deliver_later` to deliver through Active Job.					
		      DiscussionMailer.notify_discussion_owner(@comment, current_user).deliver_now
		    end
		    
				format.js { render } #render /comments/create.js.erb
				format.html { redirect_to project_path(@discussion.project), notice: "Comment created successfully" }
			else
				format.js { render } #render /comments/create.js.erb
				format.html { redirect_to project_path(@discussion.project), alert: "err: Comment didn't save!" }
			end
		end
	end

	def update
		#find_project
		#find_comment
		respond_to do |format|
			if @comment.update comment.params
				format.js { render }
				format.html { redirect_to project_path(@project), notice: "Comment updated successfully"}
			else
				format.js { render }
				format.html { render :edit, alert: "Comment failed to update"}
			end
		end
	end

	def destroy
		@comment.destroy
		respond_to do |format|
			format.js { render } #render "/comments/destroy.js.erb"
			format.html { redirect_to project_path(@discussion.project), notice: "Comment deleted successfully" }
		end

	end


	private
	def find_discussion
		@discussion = Discussion.find params[:discussion_id]
	end
	def find_comment
		@comment = Comment.find(params[:id])
	end
	def comment_params
		params.require(:comment).permit(:body)
	end
end