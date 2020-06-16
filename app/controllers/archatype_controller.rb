class ArchatypeController < ApplicationController
    get "/archatypes" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @archatypes = Archatype.all
            erb :"/archatypes/index"
        else
            redirect "/login"
        end 
    end
    get "/archatypes/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @archatype = Archatype.find_by_id(params[:id])
            erb :"archatypes/show"
        else
            redirect "/login"
        end
    end
end