class LeadsController < ApplicationController
  def index
    @leads = Lead.all
  end

  def show
    @lead = Lead.find(params[:id])
  end

  def new
    @lead = Lead.new
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
  end

  def update
    @lead = Lead.find(params[:id])

    if @lead.update(lead_params)
      if lead_params[:status] == 'sale'
        @description = 'The project is given by the client==>' + @lead.client_name + ', which will be developed using ' + @lead.platform + ' platform.'
        redirect_to projects_new_path(:project => {:title => @lead.project_name, :description => @description, :lead_id => @lead.id})
      else
        redirect_to @lead
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lead = Lead.find(params[:id])
    @lead.destroy

    redirect_to root_path
  end

  private
    def lead_params
      params.require(:lead).permit(:project_name, :client_name, :client_address, :client_email, :client_contact, :platform, :test_type, :status, :user_id)
    end

end
