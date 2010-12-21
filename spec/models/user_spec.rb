require 'spec_helper'

describe User do
  let(:user) { User.new }
  let(:omni_params) { {"provider" => "facebook", "uid" => 92718, "user_info" => {"nickname" => "bob"}, "extra" => {"user_hash" => {"email" => "bar@foo.com"}}} }

  context "#associate_auth" do
    let(:auths) { mock "auths" }
    before { user.stub :user_authentications => auths }

    context "when no such association currently exists" do
      before { auths.stub_chain :where, :count => 0 }

      it "should save an associated auth source" do
        auths.should_receive(:create!)
        user.associate_auth(omni_params)
      end
    end

    context "when the exact association already exists" do
      before { auths.stub_chain :where, :count => 1 }

      it "should not create duplicate auth" do
        auths.should_not_receive(:create!)
        user.associate_auth(omni_params)
      end
    end

  end

end