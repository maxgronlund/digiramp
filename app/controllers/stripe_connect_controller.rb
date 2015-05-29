class StripeConnectController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    current_user.stripe_id              = auth_hash['uid']
    current_user.stripe_access_key      = auth_hash['credentials']['token']
    current_user.stripe_publishable_key = auth_hash['info']['stripe_publishable_key']
    current_user.stripe_refresh_token   = auth_hash['credentials']['refresh_token']
    current_user.save!
    flash[:notice] = "Stripe info saved"
    redirect_to '/stripe/success'
  end

end


