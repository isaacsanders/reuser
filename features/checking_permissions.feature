Feature: Checking Permissions
  In order to restrict my application
  As a developer
  I want to check permissions of my users

  Scenario: Checking permissions on an empty role
    Given the following class:
    """
    class User
      include ReUser
      attr_reader :role

      roles do
        role :admin
      end

      def initialize role
        @role = role
      end
    end
    """
    When I create an "admin" user
      And I ask if the user can read
    Then I learn that they can't

  Scenario: Checking permissions on a role with those permissions
    Given the following class:
    """
    class User
      include ReUser
      attr_reader :role

      roles do
        role :admin do
          can :read
        end
      end

      def initialize role
        @role = role
      end
    end
    """
    When I create an "admin" user
      And I ask if the user can read
    Then I learn that they can

  Scenario: Checking conditional permissions
    Given the following class:
    """
    class User
      include ReUser
      attr_reader :role

      roles do
        role :admin do
          could :write do |language|
            language == "English"
          end
        end
      end

      def initialize role
        @role = role
      end
    end
    """
    When I create an "admin" user
      And I ask if the user could write "English"
    Then I learn that they can

  Scenario: Checking conditional permissions
    Given the following class:
    """
    class User
      include ReUser
      attr_reader :role

      roles do
        role :admin do
          could :write do |language|
            language == "English"
          end
        end
      end

      def initialize role
        @role = role
      end
    end
    """
    When I create an "admin" user
    And I ask if the user could write "Japanese"
    Then I learn that they can't

  Scenario: Checking permissions with a predicate
    Given the following class:
    """
    class User
      include ReUser
      attr_reader :role

      roles do
        role :child do
          could :read, &:old_enough?
        end
      end

      def initialize role
        @role = role
        @age = 6
      end

      def old_enough?
        @age > 5
      end
    end
    """
    When I create a "child" user
    And I ask if the user can read
    Then I learn that they can

  Scenario: Checking permissions without state
    Given the following class:
    """
    class User
      include ReUser
      attr_reader :role

      roles do
        role :child do
          could :read do
            true
          end
        end
      end

      def initialize role
        @role = role
      end
    end
    """
    When I create a "child" user
    And I ask if the user can read
    Then I learn that they can
