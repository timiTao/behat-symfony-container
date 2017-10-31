Feature: Config
  In order to configure behat for my needs
  As a feature automator
  I need to be able to use behat configuration file

  Scenario: Empty configuration file
    Given a file named "behat.yml" with:
    """
    default:
        extensions:
            TimiTao\BehatSymfonyContainer\ServiceContainer\Extension: ~
    """
    And a file named "features/bootstrap/FeatureContext.php" with:
    """
      <?php
      use Behat\Behat\Context\Context;
      class FeatureContext implements Context
      {
      }
      """
    And a file named "features/feature.feature" with:
    """
      Feature:
        Scenario:
          When this scenario executes
      """
    When I run "behat -f progress"
    Then it should pass