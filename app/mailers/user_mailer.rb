class UserMailer < ApplicationMailer
    default from: 'from@example.com'

    def welcome_email
        @user = params[:user]
        @phase_id = params[:phase_id]
        @lead_id = params[:lead_id]
        @phase_url  = 'http://127.0.0.1:3000/leads/' + @lead_id.to_s + '/phases/' + @phase_id.to_s
        @resp_url = 'http://127.0.0.1:3000/leads/' + @lead_id.to_s + '/phases/' + @phase_id.to_s + '/respond'
        mail(to: @user.email, subject: 'Phase Assignment Confirmation')
    end
end
