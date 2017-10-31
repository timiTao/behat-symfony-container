[![License](https://poser.pugx.org/timitao/behat-symfony-container/license.svg)](https://packagist.org/packages/timitao/behat-symfony-container)
[![Latest Stable Version](https://poser.pugx.org/timitao/behat-symfony-container/v/stable.svg)](https://packagist.org/packages/timitao/behat-symfony-container)

# Behat Symfony Extension

This extension provide isolated symfony container from Behat.

This extension borrow a lot from [extension](https://github.com/FriendsOfBehat/ServiceContainerExtension), but:
- don't force minimal PHP version to 7.1,
- have isolated container. 

# Configuration 

1. Install it:
    
    ```bash
    $ composer require timitao/behat-symfony-container --dev
    ```

2. To enable this extension and load container:
    
    ```yaml
    # behat.yml
    default:
        suites:
            default:
                services: "@timitao_behat_symfony_container.container"
        extensions:
            TimiTao\BehatSymfonyContainer\ServiceContainer\Extension:
                imports:
                    - "PATH_TO_FILE"
                    - "PATH_TO_FILE"
                    - "PATH_TO_FILE"
    ```

3. Write services files definitions, that are [generally accepted by Symfony](https://symfony.com/doc/current/components/dependency_injection.html) with format `yml`, `xml` or `PHP`.
[Check out examples](https://github.com/timiTao/behat-symfony-container/blob/master/features/import.feature)

## Versioning
 
Staring version ``1.0.0``, will follow [Semantic Versioning v2.0.0](http://semver.org/spec/v2.0.0.html).

## Contributors

* Tomasz Kunicki [TimiTao](http://github.com/timiTao) [lead developer]