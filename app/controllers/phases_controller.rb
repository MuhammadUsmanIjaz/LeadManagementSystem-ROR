class PhasesController < ApplicationController
    def new
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.new
    end
    
    def create
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.create(phase_params)
        redirect_to @lead
    end

    def edit
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:id])
    end
    
    def update
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:id])

        if @phase.update(phase_params)
            redirect_to @lead
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:id])
        @phase.destroy
        redirect_to lead_path(@lead)
    end

    private
        def phase_params
            params.require(:phase).permit(:assignee, :start_date, :due_date, :status, :test_type, :invitation_status, :lead_id)
        end
end
