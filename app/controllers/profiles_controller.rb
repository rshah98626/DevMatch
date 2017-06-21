class ProfilesController < ApplicationController
    
    # GET to /users/:user_id/new
    def new
       # Render blank profile form
       @profile = Profile.new
    end
    
end