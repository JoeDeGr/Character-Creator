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

    get "/archatypes/new" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @archatypes = Archatype.all
            erb :"/archatypes/new"
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

    get "/archatypes/:id/edit" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @archatype = archatype.find_by_id(params[:id])
            erb :"archatypes/edit"
        else
            redirect "/login"
        end
    end

    post "/archatypes" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @archatype = []
            @power = []
            if !!params[:archatype][:name]
                @archatype = Archatype.create(params[:archatype])
            end
            if !!params[:power][:name]
                @power = Power.create(params[:power])
                @power.archatype_ids = @archatype.id
                @power.save
            end
            redirect "/archatypes"
        else
            redirect "/login"
        end
    end

    patch "/archatypes/:id" do
        @user = User.current_user(session)
        @archatype = Archatype.find_by_id(params[:id])
        @archatype.update(params[:archatype])
        binding.pry
 
        redirect "/locations/#{@location.id}"
    end

    delete "/Archatypes/:id" do
        archatype.destroy(params[:id])
        redirect "archatypes"
    end
end