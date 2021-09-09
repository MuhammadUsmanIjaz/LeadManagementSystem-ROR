class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lead

    def showphasecomments
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:phase_id])
    end

    def createphasecomment
        @lead = Lead.find(params[:lead_id])
        @phase = @lead.phases.find(params[:phase_id])
        @comment = @phase.comments.create(comment_params)
        if @comment.valid?
            redirect_to lead_phase_comments_path(@lead, @phase)    
        else
            flash[:alert] = @comment.errors.full_messages.first
            redirect_to lead_phase_comments_path(@lead, @phase)
        end
        
    end
    
    def showleadcomments
        @lead = Lead.find(params[:lead_id])
    end

    def createleadcomment
        @lead = Lead.find(params[:lead_id])
        @comment = @lead.comments.create(comment_params)
        if @comment.valid?
            redirect_to lead_comments_path(@lead)    
        else
            flash[:alert] = @comment.errors.full_messages.first
            redirect_to lead_comments_path(@lead)
        end
        
    end

    private
        def comment_params
          params.require(:comment).permit(:commenter, :body, :commentable_type,:commentable_id, avatars: [])
        end

        def set_lead
            @lead = Lead.find(params[:lead_id])
        end
end
