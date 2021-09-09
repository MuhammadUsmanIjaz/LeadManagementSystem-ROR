class LeadsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @leads = Lead.all
  end

  def show
    @lead = Lead.find(params[:id])
  end

  def new
    @lead = Lead.new
    authorize @lead
  end

  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to @lead
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @lead = Lead.find(params[:id])
    authorize @lead
  end

  def update
    @lead = Lead.find(params[:id])
    @check = true
    if lead_params[:status] == 'sale' or lead_params[:status] == 'not_sale'
      @phases = @lead.phases.all
      @phases.each do |phase|
        if phase.status != 'completed'
          @check = false
          break
        end
      end
    end

    if @check
      if @lead.update(lead_params)
        if lead_params[:status] == 'sale'
          @description = 'The project is given by the client==>' + @lead.client_name + ', which will be developed using ' + @lead.platform + ' platform.'
          redirect_to projects_new_path(:project => {:title => @lead.project_name, :description => @description, :lead_id => @lead.id}), notice: 'Congratualtions! The Lead is Successfully transitioned to Project.'
        else
          redirect_to @lead, notice: 'Lead updated Successfully!'
        end
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:alert] = 'All the Phase of this Lead are not Completed. Therefore, you can not transition this Lead to Sale or Not-Sale!'
      render :edit  
    end
  end

  def destroy
    @lead = Lead.find(params[:id])
    authorize @lead
    @lead.destroy

    redirect_to root_path
  end

  private
    def lead_params
      params.require(:lead).permit(:project_name, :client_name, :client_address, :client_email, :client_contact, :platform, :test_type, :status, :user_id)
    end

end
