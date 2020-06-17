class PowerController < ApplicationController
    delete "/powers/:id" do
        Power.destroy(params[:id])
        redirect "/powers"
    end
end