#ReUser
##Purpose
  Whenever you start a web app where a user has specific permissions, do you
  end up writing your own solution or using something that has brain-bending
  abstractions? If so, ReUser is the solution for you.
##Description
  ReUser is an Internal DSL for Ruby to create roles and manage actions.
##Usage
  Installing ReUser is easy:
  
    gem install reuser

  Now to incorporate it into a model:
  
    require 'reuser'

    class User
      include ReUser

      roles do
        role(:admin).can :read, :write, :execute
        role :user do |usr|
          usr.can :read
          usr.could :write {|obj| usr.owns?(obj)}
          usr.cant :execute
        end
        role :writer, [:read, :write]
        default :user
      end
    end

  You can restrict the instances from doing things based on role:
  
    def administrate
      if @user.role? :admin
        administer
      end
    end

  Or based on their actions:
  
    def do_something_risky
      if @user.can?(:do_this)
        do_it
      else
        tell_them_to_get_out!
      end
    end

    def do_something_with_obj
      if @user.could?(:write, file)
        write file
      else
        raise 'Not your file!'
      end
    end
    
##Issues?
  Please don't hesitate to open up an issue. You can even contribute! Which
  brings me to...
##Contributing!
  This is open source, so I want others to help too. For now I have no plans
  on adding too much more to this project, as far as functionality is
  concerned, but don't let that get in your way of opening a request or forking
  the project and adding something. I just ask that:

  - You are polite about it.
  - You test it.
  - You explain it, or it is easy to read.

  Following these will let us get along and make better software, quicker, and
  with less bugs.(hypothetically)

  I am still working on the final syntax, but we are getting closer. If you
  have any suggestions on syntax, open a feature require
