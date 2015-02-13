class TasksController < ApplicationController
	before_action :authenticate_user! 
	before_action :find_project
	before_action :find_task, only: [:edit, :show, :update, :destroy]


	def new
		#find_project
		@task = Task.new
	end
	def create
		#find_project
		@task = Task.new task_params
		@task.project = @project
		respond_to do |format|
			
			if @task.save
				format.js { render } #render "/tasks/create.js.erb"
				format.html { redirect_to project_path(@project),  notice: "Task created successfully." }
			else
				format.js { render } #render "/tasks/create.js.erb"
				format.html { redirect_to project_path(@project), alert: "Task failed upon creation" } #layout:  new_task
			end
		end
	end
	def edit
		#find_project
		#find_task
		#respond_to do |format|
	end
	def update
		#find_project
		#find_task

		old_status = @task.status

		respond_to do |format|
			if @task.update task_params
				if (current_user != @task.user) && (old_status == false) && (@task.status == true)

#DEPRECATION WARNING: `#deliver` is deprecated and will be removed in Rails 5. Use `#deliver_now` to deliver immediately or `#deliver_later` to deliver through Active Job.					
					TaskMailer.notify_task_owner(@task, current_user).deliver_now
				end

				format.js { render } #render "/tasks/update.js.erb"
				format.html { redirect_to project_path(@project), notice: "Task updated successfully" }
			else
				format.js { render } #render "/tasks/update.js.erb"
				format.html { render :edit, alert: "Task failed to update" }
			end
		end
	end
	def show
		#find_project
		#find_task
	end
	def index
		#find_project
		@entire_tasks = Task.all
	end
	def destroy
		#find_project
		#find_task
		@task.destroy
		respond_to do |format|
			format.js { render } #render "/tasks/destroy.js.erb"
			format.html { redirect_to projects_path(@project), notice: "Task deleted successfully." } 
		end
	end


	private
	def find_project
		@project = Project.find params[:project_id]
	end
	def find_task
		@task = Task.find params[:id]
	end
	def task_params
		#strong params check
		params.require(:task).permit(:title, :due_date, :body, :status, :project_id)
	end
end