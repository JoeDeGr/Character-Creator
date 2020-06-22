class PowerController < ApplicationController
    get "/powers" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @powers = Power.all
            erb :"/powers/index"
        else
            redirect "/login"
        end 
    end

    get "/powers/new" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @archatypes = Archatype.all
            erb :"/powers/new"
        else
            redirect "/login"
        end 
    end

    get "/powers/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @power = Power.find_by_id(params[:id])
            erb :"/powers/show"
        else
            redirect "/login"
        end
    end

    get "/powers/:id/edit" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @power = Power.find_by_id(params[:id])
            @archatypes = Archatype.all
            erb :"powers/edit"
        else
            redirect "/login"
        end
    end

    post "/powers" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @power = []
            if !(params[:power][:name] == "")
                @power = Power.create(params[:power])
                redirect "/powers"
            else 
                redirect "/powers/new"
            end
        else
            redirect "/login"
        end
    end

    patch "/powers/:id" do
        @user = User.current_user(session)
        @power = Power.find_by_id(params[:id])
        @power.update(params[:power])
        redirect "/powers/#{@power.id}"
    end

    delete "/powers/:id" do
        Power.destroy(params[:id])
        redirect "/powers"
    end
end