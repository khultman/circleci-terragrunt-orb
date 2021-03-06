# kchultman/terragrunt circleci orb

## Usage

### Example
```yaml
version: 2.1

orbs:
  terragrunt: kchultman/terragrunt@0.1.11

context: &context
  terraform-access-keys

master_workflow_filters: &master_workflow_filters
  filters:
    branches:
      only:
        - master

workflows:
  version: 2
  test-build-plan-apply:
    jobs:
      - terragrunt/checkout
      - terragrunt/validate_infrastructure:
          context: *context
          requires:
            - terragrunt/checkout
      - terragrunt/plan_infrastructure:
          context: *context
          requires:
            - terragrunt/validate_infrastructure
      - approve_infrastructure:
          <<: *master_workflow_filters
          context: *context
          type: approval
          requires:
            - terragrunt/plan_infrastructure
      - terragrunt/apply_infrastructure:
          <<: *master_workflow_filters
          context: *context
          requires:
            - approve_infrastructure
```