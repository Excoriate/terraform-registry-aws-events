# Changelog

## [0.1.14](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.13...v0.1.14) (2023-06-12)


### Features

* add account recovery configuration ([ec90f78](https://github.com/Excoriate/terraform-registry-aws-events/commit/ec90f78092a91e0c1f295008837b8e85a2b64798))
* add admin user config creation option ([de65e01](https://github.com/Excoriate/terraform-registry-aws-events/commit/de65e01db49e7de2fab342f172db969a92e03fd2))
* add device configuration capability ([830a40d](https://github.com/Excoriate/terraform-registry-aws-events/commit/830a40dd5c7e3fd9d77ba057604b8086e2d776aa))
* add email configuration support ([28f57a1](https://github.com/Excoriate/terraform-registry-aws-events/commit/28f57a1f2613b142790f2abbc21020f758943cc6))
* add initial configuration for user pool ([b95afaf](https://github.com/Excoriate/terraform-registry-aws-events/commit/b95afafdc4108f5d52fb2dcfb3b39718d9779a9d))
* add lambda configuration ([8956dca](https://github.com/Excoriate/terraform-registry-aws-events/commit/8956dcacfb30df2c1f90307b1b4a055c42c42a2a))
* add schema attributes configuration ([e854694](https://github.com/Excoriate/terraform-registry-aws-events/commit/e854694b95291ed53968071f87d1058ba38da1bf))
* add software mfa token support ([f75db7a](https://github.com/Excoriate/terraform-registry-aws-events/commit/f75db7a3311fe26230e2da72baace85e6761b210))
* add support for password policy ([4921cce](https://github.com/Excoriate/terraform-registry-aws-events/commit/4921ccea56a8f73d400a1d45f13d1c59cf530790))
* add support for SMS ([a6335c6](https://github.com/Excoriate/terraform-registry-aws-events/commit/a6335c6703b71a95989024bc40255dca5c4d2433))
* add user attribute update settings ([92e527f](https://github.com/Excoriate/terraform-registry-aws-events/commit/92e527f52afda10af9da06a831865c50863e0363))
* add user pool add ons configuration ([a25848c](https://github.com/Excoriate/terraform-registry-aws-events/commit/a25848cd61df5481070a707c1ad235a6e6e71bc5))
* add user-pool module ([991ce0c](https://github.com/Excoriate/terraform-registry-aws-events/commit/991ce0cf90099a6109ef5bb663e29c78d3d59aed))
* add verification template capability ([6fc9ceb](https://github.com/Excoriate/terraform-registry-aws-events/commit/6fc9ceb48a506c9ce10c76a94c2b4416dc767061))

## [0.1.13](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.12...v0.1.13) (2023-05-10)


### Bug Fixes

* Add missing putsecretvalue policy for rotation ([ad9e543](https://github.com/Excoriate/terraform-registry-aws-events/commit/ad9e54367738cf656d5d85c7afc121da5e25f0aa))

## [0.1.12](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.11...v0.1.12) (2023-05-10)


### Bug Fixes

* fix conditional resource creation of lambda permissions for secrets manager ([858cba6](https://github.com/Excoriate/terraform-registry-aws-events/commit/858cba6d74a4dbe7bd81fa3084f5028414a5b929))

## [0.1.11](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.10...v0.1.11) (2023-05-08)


### Bug Fixes

* remove logs from suffix in cloudwatch loggroup naming ([#20](https://github.com/Excoriate/terraform-registry-aws-events/issues/20)) ([35edd3f](https://github.com/Excoriate/terraform-registry-aws-events/commit/35edd3fa0b12951f487b42ec7d01eb1ca87398a8))

## [0.1.10](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.9...v0.1.10) (2023-05-08)


### Bug Fixes

* add allowed prefix for cloudwatch log group ([fc74b19](https://github.com/Excoriate/terraform-registry-aws-events/commit/fc74b19d73ff185bfeb1030ab6f4afc6afa06e3f))

## [0.1.9](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.8...v0.1.9) (2023-05-07)


### Bug Fixes

* remove inconsistent precondition ([e99e2a5](https://github.com/Excoriate/terraform-registry-aws-events/commit/e99e2a55758b11aedd0df8bcd2b3a0a520a49774))

## [0.1.8](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.7...v0.1.8) (2023-05-07)


### Refactoring

* Add missing input variables in old recipes ([9f233e3](https://github.com/Excoriate/terraform-registry-aws-events/commit/9f233e33d8b7d1ce74f1fee9f9c4fc00b02a2adc))

## [0.1.7](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.6...v0.1.7) (2023-05-07)


### Features

* Add rotator specific configuration ([#15](https://github.com/Excoriate/terraform-registry-aws-events/issues/15)) ([2328f0c](https://github.com/Excoriate/terraform-registry-aws-events/commit/2328f0c24e16eee5c363f271bcf6473468d488bb))

## [0.1.6](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.5...v0.1.6) (2023-05-07)


### Features

* add custom permissions for rotating secrets ([ad50631](https://github.com/Excoriate/terraform-registry-aws-events/commit/ad506318526a127ff3428dfbb601b010eab17def))

## [0.1.5](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.4...v0.1.5) (2023-05-07)


### Features

* Add internal lookup for secrets when secrets manager permissions are set ([#12](https://github.com/Excoriate/terraform-registry-aws-events/issues/12)) ([75d4718](https://github.com/Excoriate/terraform-registry-aws-events/commit/75d471813786f9f792ba5da28c6f7758ee83b050))

## [0.1.4](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.3...v0.1.4) (2023-05-07)


### Bug Fixes

* Fix permissions in enabling optional secret manager invoke permissions ([1ff5662](https://github.com/Excoriate/terraform-registry-aws-events/commit/1ff56626ed232babab7c0e1697c3def5f4de4e30))

## [0.1.3](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.2...v0.1.3) (2023-05-01)


### Other

* remove comments ([c3fa23e](https://github.com/Excoriate/terraform-registry-aws-events/commit/c3fa23e1335f7fac99dc6b17d666e9ab17ec679e))

## [0.1.2](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.1...v0.1.2) (2023-04-18)


### Features

* add eventbridge permissions module ([8ef4f3d](https://github.com/Excoriate/terraform-registry-aws-events/commit/8ef4f3d300f26ae087dae5662056e38cc5d6f17c))

## [0.1.1](https://github.com/Excoriate/terraform-registry-aws-events/compare/v0.1.0...v0.1.1) (2023-04-17)


### Features

* add event bridge rule module ([59ac858](https://github.com/Excoriate/terraform-registry-aws-events/commit/59ac858cd47c992eb881c3184a1d6020c4c87fc3))
* add first structure, and related configuration ([fde9bb7](https://github.com/Excoriate/terraform-registry-aws-events/commit/fde9bb75dbb1701b8ef2732b920c154c7cc1132a))
