class ProjectsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @projects = Project.all
        @tms = User.with_role(:TechnicalManager, current_user)
        @tech = []
        @tms.each do |tm|
            @tech << tm.name
        end
    end

    def create
        @project = Project.new(project_params)
    
        if @project.save
          redirect_to projects_path(@project)
        else
          render :index, status: :unprocessable_entity
        end
    end

    def destroy
        @project = Project.find(params[:id])
        authorize @project
        @project.destroy

        redirect_to projects_path
    end

    def addmanagers
        @name = params[:TM]
        @project = Project.find(params[:id])
        authorize @project
        if @project.update(:assignee => @name)
            redirect_to projects_path(@project)
        else
            render :index, status: :unprocessable_entity
        end
    end 
    private
        def project_params
            params.require(:project).permit(:title, :description, :lead_id)
        end


end
