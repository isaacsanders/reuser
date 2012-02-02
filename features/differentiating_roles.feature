@focus
Feature: Differentiating Roles
  In order to tell my roles apart
  As a developer
  I want to be able to know my roles' names and their permissions

  Scenario: One role's name
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role :admin
      end
    end
    """
    When I access "User.role(:admin).name"
    Then I should have know my role's name is "admin"

  Scenario: Two roles' have different names
    Given the following class:
    """
    class User
      include ReUser

      roles do
        role :admin
        role :user
      end
    end
    """
    When I access "User.role(:user).name"
    Then I should have know my role's name is "user"
