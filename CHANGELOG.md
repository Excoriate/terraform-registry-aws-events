# Changelog

## [0.1.4](https://github.com/Excoriate/terraform-registry-aws-rds/compare/v0.1.3...v0.1.4) (2024-01-26)


### Features

* Add auth block support ([06cb8ee](https://github.com/Excoriate/terraform-registry-aws-rds/commit/06cb8ee5f46f29a5cc9085bac4bec77febeb4326))
* Add targets ([dedeaee](https://github.com/Excoriate/terraform-registry-aws-rds/commit/dedeaee82b901d8cf12fe651285b642e6f46416f))
* Add wip db proxy module ([bd5a8c6](https://github.com/Excoriate/terraform-registry-aws-rds/commit/bd5a8c6c8bcd8a2c9cc66bea08d463582743d249))
* WIP changes on db proxy module ([74a95bf](https://github.com/Excoriate/terraform-registry-aws-rds/commit/74a95bf418f0255ec1c0c6980cd11fa0c7118905))


### Other

* Comment temporily failed tflint hook ([f67419b](https://github.com/Excoriate/terraform-registry-aws-rds/commit/f67419b0431f05932fb748b52cb03f61825df20b))
* Update docs ([a9ee0e9](https://github.com/Excoriate/terraform-registry-aws-rds/commit/a9ee0e90f34f7397e3313c2c8e9ea7e5fcd9527a))


### Docs

* Add initial readme ([b3c761d](https://github.com/Excoriate/terraform-registry-aws-rds/commit/b3c761d5cf2296abe2ef5f5cee2ece310569d9d4))
* Add updated docs ([85032b9](https://github.com/Excoriate/terraform-registry-aws-rds/commit/85032b95da0059d5797df9825ce4853f2c4b1d68))
* Add updated docs ([f897a41](https://github.com/Excoriate/terraform-registry-aws-rds/commit/f897a417e25158edef208ce831a0ac79ca335f3f))

## [0.1.3](https://github.com/Excoriate/terraform-registry-aws-rds/compare/v0.1.2...v0.1.3) (2023-12-17)


### Bug Fixes

* Subnets and related network data isn't resolved when vpc_id is passed ([aa2c777](https://github.com/Excoriate/terraform-registry-aws-rds/commit/aa2c7770963f619ea600e7ab4fbc231a75ea7238))

## [0.1.2](https://github.com/Excoriate/terraform-registry-aws-rds/compare/v0.1.1...v0.1.2) (2023-12-17)


### Features

* Add security group module ([a01c1cb](https://github.com/Excoriate/terraform-registry-aws-rds/commit/a01c1cb058862b401c7e7eb155a51c9507ed6602))
* Addd logic for dynamic inbound and outbound sg ids ([12f5a05](https://github.com/Excoriate/terraform-registry-aws-rds/commit/12f5a05afbfe37c574bf344f753192c8335a745b))


### Docs

* Add missing docs ([b3349a2](https://github.com/Excoriate/terraform-registry-aws-rds/commit/b3349a2fe623da5c951bebd40c0762d81b066296))

## [0.1.1](https://github.com/Excoriate/terraform-registry-aws-rds/compare/v0.1.0...v0.1.1) (2023-12-15)


### Features

* Add support for fetch dynamically subnets for subnet_groups through vpc name ([9f5e90a](https://github.com/Excoriate/terraform-registry-aws-rds/commit/9f5e90afbe498f167463ee1ccfec1c1c8093b883))

## 0.1.0 (2023-12-14)


### Features

* add compelted code ([ae3ea78](https://github.com/Excoriate/terraform-registry-aws-rds/commit/ae3ea7813127da04eda076f14a576be1771d4c20))
* add hook for tf docs ([0b7ee31](https://github.com/Excoriate/terraform-registry-aws-rds/commit/0b7ee312c5592e1e5212617f7ec4bacb35be89c1))
* add hook for tf docs ([9825a16](https://github.com/Excoriate/terraform-registry-aws-rds/commit/9825a1630bef8a5d39e24d8700dd8989a67081d6))
* add hook for tf docs ([1028a02](https://github.com/Excoriate/terraform-registry-aws-rds/commit/1028a02fb9ae1e4d0b8b3c7fc70f9fb914074ece))
* add makefile mirroring tasks in taskfile ([06a8973](https://github.com/Excoriate/terraform-registry-aws-rds/commit/06a8973433ba73d83f9bce85738badf083e25388))
* add option for excluding directories and files ([d3786a3](https://github.com/Excoriate/terraform-registry-aws-rds/commit/d3786a3e2f845d7f3dfc44f7ebe8d798545ccee1))
* Add rds-cluster basic features ([647186f](https://github.com/Excoriate/terraform-registry-aws-rds/commit/647186f87bff8e171e5a2c9ba91d4842c130ee53))
* Add stable version ([e633b75](https://github.com/Excoriate/terraform-registry-aws-rds/commit/e633b750a4f08b9ecf9637714d37c3a13cc5f593))
* add stable version of dagger package ([cd3916c](https://github.com/Excoriate/terraform-registry-aws-rds/commit/cd3916c28a268e0c60f4f68e8642b75ce8a3652a))
* add terraform plan command, mvp ([e28da0f](https://github.com/Excoriate/terraform-registry-aws-rds/commit/e28da0fdb73268b9893e0008058c7189d94c3e95))
* add working version of dagger pipeline ([941c6e9](https://github.com/Excoriate/terraform-registry-aws-rds/commit/941c6e90df41d4d3d8dcd46e7a8b67293c4e08a2))
* Addd parameter group capabilities ([0ff511c](https://github.com/Excoriate/terraform-registry-aws-rds/commit/0ff511c7b1eaef0a05a034cebadd77bb86a73064))
* first commit ([02e7bf8](https://github.com/Excoriate/terraform-registry-aws-rds/commit/02e7bf8c97f78d75db9a05b1d3a08e14bf093fd0))
* Fix dynamic rule creation for security grups built-in capability ([1c26fb4](https://github.com/Excoriate/terraform-registry-aws-rds/commit/1c26fb48158e3026f3257574653629fbce57605a))


### Bug Fixes

* Add better tasks, added missing docs in recipes ([b5921d6](https://github.com/Excoriate/terraform-registry-aws-rds/commit/b5921d67d77f0d4948f4f7e67985371f9e99e866))
* Add better tasks, added missing docs in recipes ([885f0e5](https://github.com/Excoriate/terraform-registry-aws-rds/commit/885f0e52f373e62426017b87e7bfc272d5488d53))
* Add fix for serverless scaling configuration v1 and v2 ([c581d18](https://github.com/Excoriate/terraform-registry-aws-rds/commit/c581d1816025c2b573e06846ee31036354162198))


### Refactoring

* Adapt template ([5f5e3aa](https://github.com/Excoriate/terraform-registry-aws-rds/commit/5f5e3aa2fed5649ef6369454b50f0cd64bc5e07b))
* Add other modules ([1bd890c](https://github.com/Excoriate/terraform-registry-aws-rds/commit/1bd890c81e3a3528c9d8d3c490110e11ef0f3517))
* Changed feature flag logic, add security groups ([d36d63f](https://github.com/Excoriate/terraform-registry-aws-rds/commit/d36d63fc2ccb6f2b955e8cf268a0e7aca07e75eb))
* Fix hooks, add iam-roles support ([6dff7d8](https://github.com/Excoriate/terraform-registry-aws-rds/commit/6dff7d8e3b57f955a0358ae71ebfcf0b452351d3))


### Docs

* add missing README.md docs for recipes ([099be35](https://github.com/Excoriate/terraform-registry-aws-rds/commit/099be350c92a252bf1b6ae7b0047dc27f89db8b7))
* add missing README.md docs for recipes ([43738ae](https://github.com/Excoriate/terraform-registry-aws-rds/commit/43738aeac49ed78b3953f69b99ce8c02ece40b8b))
