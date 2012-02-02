Feature: Checking Permissions
  In order to restrict my application
  As a developer
  I want to check permissions of my users

  Scenario: Checking permissions on an empty role
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role :admin
      end

      def initialize role_name
        @role = User.role(role_name)
      end
    end
    """
    When I create an "admin" user
      And I ask if the user can read
    Then I learn that the user can't read

  Scenario: Checking permissions on a role with those permissions
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role :admin do |admin|
          admin.can :read
        end
      end

      def initialize role_name
        @role = User.role(role_name)
      end
    end
    """
    When I create an "admin" user
      And I ask if the user can read
    Then I learn that the user can read
