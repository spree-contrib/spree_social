UsersController.class_eval do

  update do
    failure do
      flash "There is already an account with that email. Please sign in to associate these accounts."
      wants.html do
        if @user.anonymous?
          render(:template => 'users/merge')
        else
          redirect_to edit_object_path
        end
      end
    end
  end
  update.flash { I18n.t("account_updated") }

end