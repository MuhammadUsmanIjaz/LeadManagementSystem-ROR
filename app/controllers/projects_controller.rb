class ProjectsController < ApplicationController

    def index
        @projects = Project.all
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
        @project.destroy

        redirect_to projects_path
    end

    private
        def project_params
            params.require(:project).permit(:title, :description, :lead_id)
        end


end
