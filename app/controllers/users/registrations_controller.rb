class Users::RegistrationsController < Devise::RegistrationsController
  
   # Extend default Devise gem behavior so that
   # users signing up with Pro account save with a special Stripe subscription
   # Otherwise signs user up like usual
   
   def create
       super do |resource|
           if params[:plan]
               resource.plan_id = params[:plan]
               if resource.plan_id == 2
                  resource.save_with_subscription
               else
                  resource.save 
               end
           end
       end
   end
end