class ChargesController < ApplicationController
    before_action :authorize_user
    before_action :new?, only: [:new, :create]
    before_action :downgrade?, only: [:downgrade]
    
    def create
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )
        
        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: 10_00,
            description: "Blocipedia Membership - #{current_user.email}",
            currency: 'usd'
        )
        
        current_user.premium!
        redirect_to wikis_path
        
        rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to new_charge_path 
    end
    
    def new
       @stripe_btn_data = {
         key: "#{ Rails.configuration.stripe[:publishable_key] }",
         description: "Blocipedia Membership - #{current_user.username}",
         amount: 10_00
       }
    end
    
    def edit 
        
    end
    
    def destroy
        if current_user.standard!
            redirect_to root_path
        end
    end
    
    
    
    def new?
        if current_user.standard? 
            true
        else
            redirect_to downgrade_path
        end
    end
    
    def downgrade?
       if current_user.premium?
           true
       else
           redirect_to new_charge_path
       end
    end
end
