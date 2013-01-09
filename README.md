#ReUser [![Build Status](https://secure.travis-ci.org/isaacsanders/reuser.png?branch=master)](http://travis-ci.org/isaacsanders/reuser)

##Purpose

Whenever you start a web app where a user has specific permissions, do you end
up writing your own solution or using something that has brain-bending
abstractions? If so, ReUser is the solution for you.

##Description

ReUser is an Internal DSL for Ruby to create roles and manage actions.

##Usage

Installing ReUser is easy:

    gem install reuser

Now to incorporate it into a model:

```ruby
require 'reuser'

class User
  include ReUser

  roles do

    # declare a role with the can method, taking a list of actions.
    role(:admin).can :read, :write, :execute

    role :user do |usr| # pass a block, so you can
      usr.can :read

      # declare a role, then declare a conditional action with could.
      # could takes a list of names, then assigns a test to them.
      # You can then ask your model:
      usr.could?(:write, 'un-owned-file')
      #=> false
      # or
      usr.could?(:write, 'owned-file')
      #=> true
      # could? will pass the second argument as the block's argument'

      usr.could :write do |file|
        usr.owns? file
      end
    end

    # Or you can declare a role with the name, followed by an array of names
    role :writer, [:read, :write]

    # Then, you can declare a default, accessible by storing :default as
    # your model's role, it will point to original role.
    default :user
  end
end
```

You can restrict the instances from doing things based on role:

```ruby
def administrate
  if @user.role? :admin
    administer
  end
end
```

Or based on their actions:

```ruby
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
```

##Issues?

Please don't hesitate to open up an issue. You can even contribute! Which brings me to...

##Contributing!

This is open source, so I want others to help too. For now I have no plans on
adding too much more to this project, as far as functionality is concerned, but
don't let that get in your way of opening a request or forking the project and
adding something. I just ask that:

  - You are polite about it.
  - You test it.
  - You explain it, or it is easy to read.

Following these will let us get along and make better software, quicker, and
with less bugs.(hypothetically)

I am still working on the final syntax, but we are getting closer. If you have
any suggestions on syntax, open a feature request.
