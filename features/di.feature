Feature: DI system

  As a developer I want to be able to inject
  a set of services for my project

  Scenario: I see the parsed dependencies from a directory
    Given a directory with a service "lab-test"
    When I initialize the DI
    Then I see result "test" for service "lab-test"

  Scenario: I can use different implementations of a registered service
    Given a directory with a service "lab-testWithImplementations"
    Given an implemenation "implementationA" in service "lab-testWithImplementations"
    Given an implemenation "implementationB" in service "lab-testWithImplementations"
    Given a directory with a service "otherImplementation"
    When I initialize the DI
    Then I see result "result A" for service "lab-testWithImplementations" with implementation "implementationA"
    Then I see result "result B" for service "lab-testWithImplementations" with implementation "implementationB"

  Scenario: I can register a module
    Given a directory with a service "lab-test"
    When I register the service "lab-test"
    Then I see result "test" for service "lab-test"

  Scenario: I can use dependencies in a factory
    Given a directory with a service "lab-test"
    Given a directory with a service "factory-test"
    When I initialize the DI
    Then I see result "factory-test" for service "factory-test"

  Scenario: I got error in case of a service does not exist
    When I register the service "empty"
    Then I see error "Cannot find module"

  Scenario: Use an ES6 module
    Given a directory with a service "es6-module"
    When I register the service "es6-module"
    Then I see result "test" for service "es6-module"

  Scenario: Not existent implementation
    Given a directory with a service "lab-testWithImplementations"
    When I get a not existent implementation for service "lab-testWithImplementations"
    Then I see error "Can not found the implementation"

  Scenario: Using node modules
    Given I initialize the DI
    Given a node module "lab-config"
    Given I register the node module service "lab-config" with name "config"
      | implementation |
      | memory         |
    Given a config value "implementationA" for key "test"
    Given a node module "lab-test"
    When I register the node module service "lab-test" with name "test"
      | implementation  |
      | implementationA |
      | implementationB |
    Then I see result "result A" for service "test"
