class BuildingController < ApplicationController
    get "/buildings" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @buildings = Building.all
            erb :"buildings/index"
        else
            redirect "/login"
        end
    end

    get "/buildings/new" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @characters = @user.characters
            @buildings = building.all
            @archatypes = Archatype.all
            erb :"/buildings/new"
        else
            redirect "/login"
        end 
    end
    get "/buildings/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = building.find_by_id(params[:id])
            erb :"buildings/show"
        else
            redirect "/login"
        end
    end

    get "/buildings/:id/edit" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = building.find_by_id(params[:id])
            erb :"buildings/edit"
        else
            redirect "/login"
        end
    end

    post "/buildings" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = []
            @building = []
            if !!params[:building][:name]
                @building = building.create(params[:building])
            end
            if !!params[:building][:name]
                @building = Building.create(params[:building])
                @building.building_id = @building.id
                @building.save
            end
            redirect "/buildings"
        else
            redirect "/login"
        end
    end

    patch "/buildings/:id" do
        @user = User.current_user(session)
        @building = building.find_by_id(params[:id])
        @building.update(params[:building])
        redirect "/buildings/#{@building.id}"
    end

    delete "/buildings/:id" do
        Building.destroy(params[:id])
        redirect "/buildings"
    end
end