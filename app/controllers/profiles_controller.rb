class ProfilesController < ApplicationController
    
    # GET to /users/:user_id/new
    def new
        # Render blank profile form
        @profile = Profile.new
    end
    
    #POST to user_profile_path
    def create
        # Ensure the we have the user filling out the forms
        @user = User.find(params[:user_id])
        @profile = @user.build_profile( profile_params )
        if @profile.save
            flash[:success] = "Profile updated!"
            redirect_to user_path(id: params[:user_id])
        else
        end
    end
    
    # GET request to edit users' profiles
    def edit
        @user = User.find( params[:user_id] )
        @profile = @user.profile
    end
    
    # PUT/PATCH request to update user
    def update
        # retrieve user from database
        @user = User.find( params[:user_id] )
        @profile = @user.profile
        # Mass assign if attrs had changed
        if @profile.update_attributes(profile_params)
            flash[:success] = "Profile updated"
            # Direct user to their new profile page
            redirect_to user_path(id: params[:user_id])
        else
            render action: :edit
        end
    end
    
    private
        def profile_params
           params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description) 
        end
end