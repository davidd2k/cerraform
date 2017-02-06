# Circonus

This is the Terraform repo for all things Circonus.

## Usage

There is one directory per Circonus account (e.g. `prod`, `staging`).

Inside of each directory is a top-level `GNUMakefile` that handles the manual
execution of the Terraform.  Both the `prod` and `staging` environments should
be identical and as such both environments share components via Terraform
modules.
