class ArchatypeController < ApplicationController
    get "/archatypes" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @archatypes = archatypes.all
            erb :"/archatypes/index"
        else
            redirect "/login"
        end 
    end
end