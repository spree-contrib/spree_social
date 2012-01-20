class Spree::UserAuthenticationsController < ApplicationController
  def index
  end

  def create
    render :text => auth_hash.to_yaml
  end

  def destroy
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
