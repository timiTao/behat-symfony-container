Feature: Importing services from files
  In order to declare own services inside Behat
  As a Behat User
  I need to import service definitions from files

  Background:
    Given a file named "features/bootstrap/FeatureContext.php" with:
        """
        <?php

        use Behat\Behat\Context\Context;

        class FeatureContext implements Context
        {
            private $service;

            public function __construct($service)
            {
                $this->service = $service;
            }

            /**
             * @Given the service was injected to the context
             */
            public function theParameterWasInjectedToTheContext()
            {
                if (null === $this->service) {
                    throw new \DomainException('No service was injected (or null one)!');
                }
            }

            /**
             * @Then it should be instance of :className
             */
             public function itShouldContain($className)
             {
                 if (!$this->service instanceof $className) {
                    throw new \DomainException(sprintf('Expected to get "%s", got "%s"!', $className, $this->service));
                 }
             }
        }
        """
    And a file named "features/my.feature" with:
        """
        Feature: Injecting a parameter

            Scenario:
                Given the service was injected to the context
                Then it should be instance of "\ArrayObject"
        """


  Scenario: Importing a parameter from a Yaml file
    Given a file named "behat.yml" with:
        """
        default:
            suites:
                default:
                    contexts:
                        - FeatureContext:
                            - "@test_service"
                    services: "@timitao_behat_symfony_container.container"
            extensions:
                TimiTao\BehatSymfonyContainer\ServiceContainer\Extension:
                    configs:
                        - features/bootstrap/config/services.yml
        """
    And a file named "features/bootstrap/config/services.yml" with:
        """
        services:
            test_service:
                class: \ArrayObject
        """
    When I run "behat -f progress -vvv"
    Then it should pass

  Scenario: Importing a parameter from a XML file
    Given a file named "behat.yml" with:
        """
        default:
            suites:
                default:
                    contexts:
                        - FeatureContext:
                            - "@test_service"
                    services: "@timitao_behat_symfony_container.container"
            extensions:
                TimiTao\BehatSymfonyContainer\ServiceContainer\Extension:
                    configs:
                        - features/bootstrap/config/services.xml
        """
    And a file named "features/bootstrap/config/services.xml" with:
        """
        <container xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://symfony.com/schema/dic/services">
            <services>
                <service id="test_service" class="\ArrayObject"></service>
            </services>
        </container>
        """
    When I run "behat -f progress"
    Then it should pass

  Scenario: Importing a parameter from a PHP file
    Given a file named "behat.yml" with:
        """
        default:
            suites:
                default:
                    contexts:
                        - FeatureContext:
                            - "@test_service"
                    services: "@timitao_behat_symfony_container.container"
            extensions:
                TimiTao\BehatSymfonyContainer\ServiceContainer\Extension:
                    configs:
                        - features/bootstrap/config/services.php
        """
    And a file named "features/bootstrap/config/services.php" with:
        """
        <?php

        $container->set('test_service', new \ArrayObject());
        """
    When I run "behat -f progress"
    Then it should pass