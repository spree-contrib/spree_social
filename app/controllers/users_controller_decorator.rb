UsersController.class_eval do
  
  update do
    failure do 
      flash "There is already an account with that email. Please sign in to associate the current account."
      wants.html do
        render(:template => 'users/merge')
      end
    end
  end
  update.flash { I18n.t("account_updated") }
  
end