class LocationController < ApplicationController
    get "/locations" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @locations = Location.all
            erb :"locations/index"
        else
            redirect "/login"
        end
    end

    get "/locations/new" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @characters = @user.characters
            @locations = Location.all
            @archatypes = Archatype.all
            erb :"/locations/new"
        else
            redirect "/login"
        end 
    end
    get "/locations/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @location = Location.find_by_id(params[:id])
            erb :"locations/show"
        else
            redirect "/login"
        end
    end

    get "/locations/:id/edit" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @location = Location.find_by_id(params[:id])
            erb :"locations/edit"
        else
            redirect "/login"
        end
    end

    post "/locations" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @location = []
            @building = []
            if !(params[:location][:name] == "")

                @location = Location.create(params[:location])
                
                if !(params[:building][:name] == "")

                    @building = Building.create(params[:building])
                    @building.location_id = @location.id
                    @building.save
                end
                redirect "/locations/#{@location.id}"
            else
                redirect "/locations/new"
            
            end
        else
            redirect "/login"
        end
    end

    patch "/locations/:id" do
        @user = User.current_user(session)
        @location = Location.find_by_id(params[:id])
        @location.update(params[:location])
        redirect "/locations/#{@location.id}"
    end

    delete "/locations/:id" do
        Location.destroy(params[:id])
        redirect "/locations"
    end
end