module SpreeSocial
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_stylesheets
        inject_into_file "app/assets/stylesheets/store/all.css", " *= require store/social\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'rake railties:install:migrations FROM=spree_social'
      end

      def run_migrations
         res = ask "Would you like to run the migrations now? [Y/n]"
         if res == "" || res.downcase == "y"
           run 'rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end
    end
  end
end
