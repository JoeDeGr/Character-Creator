class UserController < ApplicationController

    get "/login" do
        if User.is_logged_in?(session)
            redirect "/user/show"
        else
            erb :"/user/login"
        end
    end

    get "/signup" do
        "Hello World"
    end

    get "/user/show" do
        "Hello World"
    end

    
end