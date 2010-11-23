require 'spec_helper'

describe OmniauthCallbacksController do

  let(:user) {mock_model(User, :associate_auth => nil, :valid? => true)}
  let(:omni_params) { mock "omni" }
  let(:order) { mock_model(Order, :associate_user! => nil ) }
  
  before do 
    request.env["omniauth.auth"] = omni_params
    controller.stub :sign_in_and_redirect
    controller.stub :redirect_back_or_default
  end
  
  shared_examples_for "denied_permissions" do
    it "should redirect properly" do
      controller.should_receive(:redirect_back_or_default)
      controller.facebook
    end
    it "should display error message" do
      controller.facebook
      flash[:error].should_not be_blank
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
  
  context "when a user is not authenticated" do
    before { controller.stub :current_user => nil }
    
    context "#callback" do
      context "when user denies permissions" do
        before {request.env["omniauth.error"] = "FAIL"}
        
        context "when user is not authenticated" do
           before { controller.stub :current_user => nil }
           
           it "should not attempt authentication" do
             controller.should_not_receive(:sign_in_and_redirect)
             controller.facebook
           end
           
           it_should_behave_like "denied_permissions"
        end
        
        context "when a user is authenticated" do
          before { controller.stub :current_user => user }
          it "should not asso. with existing user" do
            user.should_not_receive(:associate_auth)
            controller.facebook
          end
          
          it_should_behave_like "denied_permissions"
        end
        
      end
      context "when no user asso. with account" do
        before do
          User.stub :anonymous! => user
          user.stub :populate_from_omniauth
        end
        
        it "should create a new user" do
          User.should_receive(:anonymous!).and_return user
          controller.facebook
        end
        
        it "should asso. user with oauth account" do
          user.should_receive(:associate_auth).with(omni_params)
          controller.facebook
        end
        
        it "should authenticate as that user" do
          controller.should_receive(:sign_in_and_redirect).with(user, :event => :authentication)
          controller.facebook
        end
        it "should populate from omniauth" do
          user.should_receive(:populate_from_omniauth).with(omni_params)
          controller.facebook
        end
        
        it_should_behave_like "associate_order"
      end
      
      context "when a user is asso. with account" do
        before { controller.stub :current_user => user }
        
        it "should asso. user with oauth account" do
          user.should_receive(:associate_auth).with(omni_params)
          controller.facebook
        end
        
        it "should authenticate as that user" do
          controller.should_receive(:sign_in_and_redirect).with(user, :event => :authentication)
          controller.facebook
        end
        
        it_should_behave_like "associate_order"
      end
    end
  end
  
  context "when a user is authenticated" do
    before { controller.stub :current_user => user }
    
    context "#callback" do
      it "should asso. user with oauth account" do        
        user.should_receive(:associate_auth).with(omni_params)
        controller.facebook
      end
    end
  end
  
end

