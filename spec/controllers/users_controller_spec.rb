require 'spec_helper'

describe UsersController do

  let(:user) {mock_model(User, :associate_auth => nil, :valid? => true, :populate_from_omniauth => nil, :has_role? => nil)}
  #let(:omni_params) { mock("omni", :[] => nil) }
  #let(:order) { mock_model(Order, :associate_user! => nil ) }

  # before do
  #   request.env["omniauth.auth"] = omni_params
  #   controller.stub :sign_in_and_redirect
  #   controller.stub :redirect_back_or_default
  #   User.stub :anonymous! => user
  # end

  before do
    User.stub :find => user
    controller.stub :current_user => user
  end

  context "#update" do
    context "validation failure" do
      before { user.stub :update_attributes => false }

      context "for anonymous user" do
        before { user.stub :anonymous? => true }

        it "should redirect to the existing social page if the email is taken" do
          post :update, { :password => "foofah" }
          response.should render_template "users/merge"
        end
      end

      context "for registered user" do
        before { user.stub :anonymous? => false }

        it "should not redirect to the existing social page for standard validation problems" do
          post :update, { :password => "foofah" }
          response.should redirect_to edit_user_path(user)
        end
      end

    end

  end

end