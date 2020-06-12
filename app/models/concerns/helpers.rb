module Helpers 
    module ClassMethods
        def current_user(session)
            binding.pry

            @user = User.find_by_id(session)
        end

        def is_logged_in?(session)
            !!session[:user_id]
        end
        def find_by_slug(slug)
            self.all.find{|a| a.slug == slug}
        end
    end
    module InstanceMethods
        def slug
            self.name.downcase.gsub(" ", "-")
        end
    end
end
