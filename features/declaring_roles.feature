Feature: Declaring Roles
  In order to have simple role-based permissions
  As a developer
  I want to declare roles in my source code

  Scenario: Declaring one role
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role :admin
      end
    end
    """
    When I access "User.roles"
    Then I should have an array of 1 ReUser::Role

  Scenario: Declaring a role with permissions
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role(:admin) do |admin|
          admin.can :create
          admin.can :read
          admin.can :update
          admin.can :delete
        end
      end
    end
    """
    When I access "User.roles"
    Then I should have an array of 1 ReUser::Role
