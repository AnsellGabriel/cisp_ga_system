class ApplicationController < ActionController::Base
    # before_action :authenticate_user!
    def after_sign_up_path_for(resource)
        root_path
    end
    @current_event = CoopEvent.find_by(active: 1)
end
