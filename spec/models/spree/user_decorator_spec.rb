require 'spec_helper'

describe Spree::User do
  let(:user) { FactoryGirl.create(:user) }
  let(:omni_params) { {"provider" => "twitter", "uid" => 12345} }
  let(:auths) { mock "auths" }

  context "#apply_omniauth" do
    before { user.stub :user_authentications => auths }

    it "should build an associated auth source" do
      auths.should_receive(:build)
      user.apply_omniauth(omni_params)
    end
    
    context "omniauth params contains email" do
      let(:user) { FactoryGirl.create(:user) {|user| user.email = nil} }
      let(:omni_params) { {"provider" => "google_oauth2", "uid" => 12345, 'info' => {'email' => 'test@example.com'}} }
      
      it "should set email from omniauth params" do
        auths.should_receive(:build)
        user.apply_omniauth(omni_params)
        user.email.should == 'test@example.com'
      end
    end
  end

  context "#password_required?" do
    before { user.password = nil }

    context "user authentications is empty" do
      it "should be true" do
        user.password_required?.should be_true
      end
    end

    context "user authentications is not empty" do
      before do
        user.stub :user_authentications => auths
        auths.stub(:empty?).and_return(false)
      end

      it "should be false" do
        user.password_required?.should be_false
      end
    end

    context "when the password has been set" do
      before { user.password = "foobar" }

      it "should be true" do
        user.password_required?.should be_true
      end
    end
  end
end
