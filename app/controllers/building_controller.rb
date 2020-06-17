class BuildingController < ApplicationController

    delete "/buildings/:id" do
        Building.destroy(params[:id])
        redirect "/buildings"
    end
end