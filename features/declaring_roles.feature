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
    Then I should have an array of 1 role

  Scenario: Declaring many roles
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role :admin
        role :user
        role :butcher
        role :baker
        role :candlestick_maker
      end
    end
    """
    When I access "User.roles"
    Then I should have an array of 5 roles

  Scenario: Declaring roles outside of a block raises an error
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role :admin
      end
    end
    """
    When I access "User.role(:user)"
    Then I should get an error

  Scenario: Declaring roles with an array of permissions
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role :admin, [:read, :write, :execute]
      end
    end
    """
    Then I should know that an admin can read, write, and execute
