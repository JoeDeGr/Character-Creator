module Helpers 
    module ClassMethods
        def current_user(session)
            @user = User.find(session[:user_id])
        end

        def is_logged_in?(session)
            !!session[:user_id]
        end
        def find_by_slug
            self.all.find{|a| a.slug == slug}
        end
    end
    module InstanceMethods
        def slug
            self.name.downcase.gsub(" ", "-")
        end
    end
end
