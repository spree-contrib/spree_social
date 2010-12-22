require 'spec_helper'

describe OmniauthCallbacksController do

  let(:user) {mock_model(User, :associate_auth => nil, :valid? => true, :populate_from_omniauth => nil, :anonymous? => false)}
  let(:omni_params) { mock("omni", :[] => nil) }
  let(:order) { mock_model(Order, :associate_user! => nil ) }

  before do
    request.env["omniauth.auth"] = omni_params
    controller.stub :sign_in_and_redirect
    controller.stub :redirect_back_or_default
    User.stub :anonymous! => user
  end

  shared_examples_for "denied_permissions" do
    before {request.env["omniauth.error"] = "FAIL"}

    it "should redirect properly" do
      controller.should_receive(:redirect_back_or_default)
      controller.facebook
    end

    it "should display error message" do
      controller.facebook
      flash[:error].should_not be_blank
    end

    it "should not attempt authentication" do
      controller.should_not_receive(:sign_in_and_redirect)
      controller.facebook
    end
  end

  shared_examples_for "associate_order" do
    before { controller.stub :current_order => order }

    it "should asso. the order with the user" do
      order.should_receive(:associate_user!).with(user)
      controller.facebook
    end

    it "should destroy the guest token" do
      session[:guest_token] = "foo"
      controller.facebook
      session[:guest_token].should be_nil
    end
  end

  shared_examples_for "populate_from_omniauth" do
    it "should populate from omniauth" do
      user.should_receive(:associate_auth).with(omni_params)
      controller.facebook
    end
  end

  shared_examples_for "authenticate_as_user" do
    it "should authenticate as that user" do
      controller.should_receive(:sign_in_and_redirect).with(user, :event => :authentication)
      controller.facebook
    end
  end

  shared_examples_for "do_not_authenticate_as_user" do
    it "should not authenticate as that user" do
      controller.should_receive(:redirect_back_or_default)
      controller.facebook
    end
  end

  context "#callback" do
    context "when user is authenticated" do
      before { controller.stub :current_user => user }

      it_should_behave_like "denied_permissions"

      context "when existing user_authentication" do
        let(:user_authentication) { mock("user_authentication", :user => user) }
        before { UserAuthentication.stub_chain :where, :first => user_authentication }

        it "should not not need to associate the UserAuthentication" do
          user.should_not_receive(:associate_auth)
          controller.facebook
        end

        it "should not create a new User account" do
          User.should_not_receive :anonymous!
          controller.facebook
        end

        it "should authenticate as that user" do
          controller.should_receive(:redirect_back_or_default)
          controller.facebook
        end
      end

      context "when no existing user auth" do
        before { UserAuthentication.stub_chain :where, :first => nil }

        it "should asso. user with the source" do
          user.should_receive(:associate_auth).with(omni_params)
          controller.facebook
        end

        it "should not authenticate as that user" do
          controller.should_receive(:redirect_back_or_default)
          controller.facebook
        end
      end

      it_should_behave_like "associate_order"
      it_should_behave_like "populate_from_omniauth"
      it_should_behave_like "do_not_authenticate_as_user"
    end

    context "when user is not authenticated" do
      before { controller.stub :current_user => nil }

      it_should_behave_like "denied_permissions"

      context "when existing user_authentication" do
        let(:user_authentication) { mock("user_authentication", :user => user) }
        before { UserAuthentication.stub_chain :where, :first => user_authentication }

        it "should not not need to associate the UserAuthentication" do
          user.should_not_receive(:associate_auth)
          controller.facebook
        end

        it "should not create a new User account" do
          User.should_not_receive :anonymous!
          controller.facebook
        end

        it "should authenticate as that user" do
          controller.should_receive(:sign_in_and_redirect).with(user, :event => :authentication)
          controller.facebook
        end
      end

      context "when no existing user auth" do
        before { UserAuthentication.stub_chain :where, :first => nil }

        it "should asso. user with the source" do
          user.should_receive(:associate_auth).with(omni_params)
          controller.facebook
        end

        it "should not authenticate as that user" do
          controller.should_receive(:sign_in_and_redirect).with(user, :event => :authentication)
          controller.facebook
        end
      end

      it_should_behave_like "associate_order"
      it_should_behave_like "populate_from_omniauth"
      it_should_behave_like "authenticate_as_user"

      it "should create a new User account" do
        User.should_receive(:anonymous!).and_return user
        controller.facebook
      end
    end
  end

end