class PhasesController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @lead = Lead.find(params[:lead_id])
        @tms = User.with_role(:TechnicalManager, current_user)
        @tech = []
        @tms.each do |tm|
            @tech << tm.name
        end
        @phase = @lead.phases.new
        authorize @phase
        @user_phase = UserPhase.new
    end
    
    def create
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.create(phase_params)
        @user_phase = UserPhase.create({ "user_id"=>current_user.id, "phase_id"=>@phase.id})
        redirect_to @lead
    end

    def edit
        @lead = Lead.find(params[:lead_id])
        @tms = User.with_role(:TechnicalManager, current_user)
        @tech = []
        @tms.each do |tm|
            @tech << tm.name
        end
        @phase = @lead.phases.find(params[:id])
        authorize @phase    
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
        authorize @phase
        @phase.destroy
        redirect_to lead_path(@lead)
    end

    def addengineers    
        authorize Phase
        @engs = User.with_role(:Engineer, current_user)
        @engineers = []
        @ids = []
        @engs.each do |eng|
            @engineers << eng.name
            @ids << eng.id
        end    
        @phaseusers = UserPhase.where(phase_id: params[:id],user_id: @ids)
        

    end

    def add
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:id])
        @name = params[:Engineer]
        @user_id = User.where(name: @name).take!
        @user_phase = UserPhase.create({ "user_id"=>@user_id.id, "phase_id"=>@phase.id})
        redirect_to addengineers_lead_phase_path
    end

    def delengineer
        @user = UserPhase.where(phase_id: params[:id], user_id: params[:user_id]).take!
        @user.destroy
        redirect_to addengineers_lead_phase_path
    end

    private
        def phase_params
            params.require(:phase).permit(:assignee, :start_date, :due_date, :status, :test_type, :invitation_status, :lead_id)
        end

end
