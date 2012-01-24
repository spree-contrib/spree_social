require 'spec_helper'

describe Spree::OmniauthCallbacksController do
  let(:user) { Factory(:user) }
  let(:omni_params) { mock("omni", :[] => nil) }


  before(:each) do
    request.env["omniauth.auth"] = omni_params
    controller.stub :sign_in_and_redirect
    controller.stub :redirect_back_or_default
    Spree::User.stub :anonymous! => user
  end

  shared_examples_for "denied_permissions" do
    before { request.env["omniauth.error"] = "FAIL" }

    it "should redirect properly" do
      controller.should_receive(:redirect_back_or_default)
      controller.twitter
    end

    it "should display an error message" do
      controller.twitter
      flash[:error].should_not be_blank
    end

    it "should not attempt authentication" do
      controller.should_not_receive(:sign_in_and_redirect)
      controller.twitter
    end
  end

  context "#callback" do
    context "when user is authenticated" do
      before { controller.stub :current_user => user }

      it_should_behave_like "denied_permissions"

      context "when existing user_authentication" do
        let(:user_authentication) { mock("user_authentication", :user => user) }
        before { Spree::UserAuthentication.stub :find_by_provider_and_uid => user_authentication }

        it "should not need to create the user_authentication" do
          user.user_authentications.should_not_receive(:create!)
          controller.twitter
        end

        it "should set the flash notice" do
          controller.twitter
          flash[:notice].should_not be_blank
        end

        it "should authenticate as that user" do
          controller.should_receive(:sign_in_and_redirect)
          controller.twitter
        end
      end

      context "when no existing user_authentication" do
        before { Spree::UserAuthentication.stub :find_by_provider_and_uid => nil }
      end
    end
  end
end
