# stack-requirements

/!\ **This stack-requirements has been mostly replaced by a [public stack](https://github.com/cycloid-community-catalog/infra-amazon-req), please refer to this one.** /!\

This module aims to ease the installation of a new infrastructure by giving the possibility to
* Create an S3 bucket for the remote state
* Create an infra user allowed to access such bucket
* Create code commit repository with both admin & read-only users

Each of those component are optional and can be disabled or enabled despite some dependencies.
Please have a look at the [sample file](https://github.com/cycloidio/stack-requirements/blob/master/sample.tf) and or [variable file](https://github.com/cycloidio/stack-requirements/blob/master/s3_codecommit/variables.tf) for a better understanding.
