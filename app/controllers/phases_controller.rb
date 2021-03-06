class PhasesController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @lead = Lead.find(params[:lead_id])
        @tms = User.with_role(:TechnicalManager, current_user)
        # map method
        @tech = @tms.map {|tm| tm.name}
        @phase = @lead.phases.new
        authorize @phase
        @user_phase = UserPhase.new
    end
    
    def create
        @lead = Lead.find(params[:lead_id])
        @name = phase_params[:assignee]
        @user = User.where(name: @name).take!
        
        @phase = @lead.phases.new(phase_params)
        if @phase.save
            @user_phase = UserPhase.create({ "user_id"=>current_user.id, "phase_id"=>@phase.id})
            UserMailer.with(user: @user, phase_id: @phase.id, lead_id: @lead.id).welcome_email.deliver_now
            redirect_to @lead
        else
            redirect_to new_lead_phase_path, notice: @phase.errors.full_messages.first
        end
        
    end

    def edit
        @lead = Lead.find(params[:lead_id])
        @tms = User.with_role(:TechnicalManager, current_user)
        @tech = @tms.map {|tm| tm.name}
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

    def respond
        authorize Phase
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:id])
        if @phase.invitation_status != 'pending'
            redirect_to root_path, notice: 'Invitation Response Has Already been Submitted. You cannot submit the response again.'
        end
    end

    def saveresponse
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:id])
        if @lead.update(:status => 'in_progress') and @phase.update(:status => 'in_progress', :invitation_status => 'accepted') 
            redirect_to lead_path(@lead)
        else
            render lead_path(@lead), status: :unprocessable_entity
        end
    end

    def addcomments
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:id])
        if @lead.update(:status => 'in_progress') and @phase.update(:status => 'completed', :invitation_status => 'rejected') 
            redirect_to lead_phase_comments_path(@lead, @phase)
        else
            render lead_phase_comments_path(@lead, @phase), status: :unprocessable_entity
        end
    end

    private
        def phase_params
            params.require(:phase).permit(:assignee, :start_date, :due_date, :status, :test_type, :invitation_status, :lead_id)
        end

end
