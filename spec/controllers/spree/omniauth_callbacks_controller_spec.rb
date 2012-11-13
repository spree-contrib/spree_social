require 'spec_helper'

describe Spree::OmniauthCallbacksController do
  let(:user) { Factory(:user) }
  let(:omni_params) { mock("omni", :[] => nil).as_null_object }
  let(:order) { mock_model(Spree::Order, :associate_user => nil) }

  before(:each) do
    Rails.application.routes.default_url_options[:host] = 'test.host'
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

  shared_examples_for "associate_order" do
    before { controller.stub :current_order => order }

    it "should associate the order with the user" do
      order.should_receive(:associate_user!).with(user)
      controller.twitter
    end
  end

  shared_examples_for "authenticate_as_user" do
    it "should authenticate as that user" do
      controller.should_receive(:sign_in_and_redirect).with(user, :event => :authentication)
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

        it "should create a new user_authentication" do
          user.user_authentications.should_receive(:create!)
          controller.twitter
        end

        it "should set the flash notice" do
          controller.twitter
          flash[:notice].should_not be_blank
        end

        it "should redirect properly" do
          controller.should_receive(:redirect_back_or_default)
          controller.twitter
        end

        it_should_behave_like "associate_order"
      end
    end

    context "when user is not authenticated" do
      before { controller.stub :current_user => nil }

      it_should_behave_like "denied_permissions"

      context "when existing user_authentication" do
        let(:user_authentication) { mock("user_authentication", :user => user) }
        before { Spree::UserAuthentication.stub :find_by_provider_and_uid => user_authentication }

        it "should not need to create the user_authentication" do
          user.user_authentications.should_not_receive(:create!)
          controller.twitter
        end

        it "should not create a new user account" do
          Spree::User.should_not_receive :new
          controller.twitter
        end

        it "should authenticate as that user" do
          controller.should_receive(:sign_in_and_redirect).with(:user, user)
          controller.twitter
        end
      end

      context "when no existing user_authentication" do
        let(:user) { Spree::User.new }
        before do
          Spree::UserAuthentication.stub :find_by_provider_and_uid => nil
          controller.stub(:auth_hash).and_return('provider' => 'facebook', 'info' => {'email' => "spree@gmail.com"}, 'uid' => '123')
        end

        context "email doesn't belongs to anyone" do
          it "should create a new user" do
            controller.should_receive(:sign_in_and_redirect)
            expect { controller.twitter }.to change(Spree::User, :count).by(1)
          end
        end

        context 'email belongs to existing user' do
          before { @user = Factory(:user, :email => "spree@gmail.com") }

          it "should not create new user" do
            expect { controller.twitter }.to_not change(Spree::User, :count)
          end

          it "assigns authentication to existing user" do
            expect { controller.twitter }.to change(@user.user_authentications, :count).by(1)
          end
        end

      end
    end
  end
end
