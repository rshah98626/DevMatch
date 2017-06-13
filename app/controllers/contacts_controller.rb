class ContactsController < ApplicationController
   #GET request to /contact-us
   #Show new ontact form
   def new
      @contact = Contact.new
   end
   
   #Post request /contacts
   def create
      #Mass assignment of form fields into Contact objects
      @contact = Contact.new(contact_params)
      #Save to to database
      if @contact.save
         #Store form fields into parameters
         #gets contact info and sends an email out
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         
         #Send info to ContactMailer to email on out
         ContactMailer.contact_email(name, email, body).deliver
         
         #code for the view
         flash[:success] = "Message sent."
         redirect_to new_contact_path
      else
         #Display error if one of the fields not filled out
         flash[:danger] = @contact.errors.full_messages.join(", ")
         redirect_to new_contact_path
      end
      
   end
   
   private
      #To collect data from form, use strong params and whitelist form fields
      def contact_params
         params.require(:contact).permit(:name, :email, :comments)
      end
end