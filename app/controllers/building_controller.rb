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
            @locations = Location.all
            erb :"/buildings/new"
        else
            redirect "/login"
        end 
    end
    get "/buildings/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = Building.find_by_id(params[:id])
            @location = "... er... well... um... to be honest... we do not know where this building is. All we know is that it does exist... er... well... somewhere."
            if @building.location
                @location = @building.location.name
            end
            erb :"buildings/show"
        else
            redirect "/login"
        end
    end

    get "/buildings/:id/edit" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = Building.find_by_id(params[:id])
            @characters = @user.characters
            @locations = Location.all
            erb :"buildings/edit"
        else
            redirect "/login"
        end
    end

    post "/buildings" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @building = []
            if !!params[:building][:name]
                @building = Building.create(params[:building])
                @building.location = Location.find_by_id(params[:building][:location_id])
                @building.save
            end
            redirect "/buildings/#{@building.id}"
        else
            redirect "/login"
        end
    end

    patch "/buildings/:id" do
        @user = User.current_user(session)
        @building = Building.find_by_id(params[:id])
        @building.update(params[:building])
        @building.location = Location.find_by_id(params[:building][:location_id])
        @building.save
        redirect "/buildings/#{@building.id}"
    end

    delete "/buildings/:id" do
        Building.destroy(params[:id])
        redirect "/buildings"
    end
end