# Changelog

## [1.2.0](https://github.com/Excoriate/terraform-registry-aws-events/compare/v1.1.0...v1.2.0) (2024-05-23)


### Features

* Update resource names with random_id in cloudwatch module ([#40](https://github.com/Excoriate/terraform-registry-aws-events/issues/40)) ([62888ce](https://github.com/Excoriate/terraform-registry-aws-events/commit/62888ceac697d4a28235e9e33fc2eeaaa73d66df))
* Updated AWS IAM role names with random suffix ([#39](https://github.com/Excoriate/terraform-registry-aws-events/issues/39)) ([eae964c](https://github.com/Excoriate/terraform-registry-aws-events/commit/eae964c09a9e794ae5b7a3437a1799cf9bd04170))

## [1.1.0](https://github.com/Excoriate/terraform-registry-aws-events/compare/v1.0.0...v1.1.0) (2024-05-23)


### Features

* add account recovery configuration ([ec90f78](https://github.com/Excoriate/terraform-registry-aws-events/commit/ec90f78092a91e0c1f295008837b8e85a2b64798))
* add admin user config creation option ([de65e01](https://github.com/Excoriate/terraform-registry-aws-events/commit/de65e01db49e7de2fab342f172db969a92e03fd2))
* add capability for other options ([6b148da](https://github.com/Excoriate/terraform-registry-aws-events/commit/6b148daa8d9771d03ab426f9527d1fac47fbe02c))
* add custom permissions for rotating secrets ([ad50631](https://github.com/Excoriate/terraform-registry-aws-events/commit/ad506318526a127ff3428dfbb601b010eab17def))
* add device configuration capability ([830a40d](https://github.com/Excoriate/terraform-registry-aws-events/commit/830a40dd5c7e3fd9d77ba057604b8086e2d776aa))
* add dkim ([7e697fc](https://github.com/Excoriate/terraform-registry-aws-events/commit/7e697fc370c675b87e48cb73eff0bae4ed26a696))
* add domain identity resource ([0c02977](https://github.com/Excoriate/terraform-registry-aws-events/commit/0c02977c3f16567c6363c9c9a2fbd3dcbd004354))
* add email configuration support ([28f57a1](https://github.com/Excoriate/terraform-registry-aws-events/commit/28f57a1f2613b142790f2abbc21020f758943cc6))
* add email identities support ([d7ccf0c](https://github.com/Excoriate/terraform-registry-aws-events/commit/d7ccf0c0acd689ca74382e76d282c68e8bc3a62b))
* add event bridge rule module ([59ac858](https://github.com/Excoriate/terraform-registry-aws-events/commit/59ac858cd47c992eb881c3184a1d6020c4c87fc3))
* add eventbridge permissions module ([8ef4f3d](https://github.com/Excoriate/terraform-registry-aws-events/commit/8ef4f3d300f26ae087dae5662056e38cc5d6f17c))
* Add feature flags in CloudWatch metric stream module outputs ([#34](https://github.com/Excoriate/terraform-registry-aws-events/issues/34)) ([a8916b0](https://github.com/Excoriate/terraform-registry-aws-events/commit/a8916b03a7f87a684ad5221ed391396182cec5be))
* add first structure, and related configuration ([fde9bb7](https://github.com/Excoriate/terraform-registry-aws-events/commit/fde9bb75dbb1701b8ef2732b920c154c7cc1132a))
* add identity provider module ([cfe49ca](https://github.com/Excoriate/terraform-registry-aws-events/commit/cfe49ca355322fd67d9547d5799a7bd293e723ae))
* add initial configuration for user pool ([b95afaf](https://github.com/Excoriate/terraform-registry-aws-events/commit/b95afafdc4108f5d52fb2dcfb3b39718d9779a9d))
* Add internal lookup for secrets when secrets manager permissions are set ([#12](https://github.com/Excoriate/terraform-registry-aws-events/issues/12)) ([75d4718](https://github.com/Excoriate/terraform-registry-aws-events/commit/75d471813786f9f792ba5da28c6f7758ee83b050))
* add lambda configuration ([8956dca](https://github.com/Excoriate/terraform-registry-aws-events/commit/8956dcacfb30df2c1f90307b1b4a055c42c42a2a))
* add minimal version for user pool client ([8ca18cb](https://github.com/Excoriate/terraform-registry-aws-events/commit/8ca18cb9834b2be572f3005d8da07b25c2511ff6))
* add oauth configuration capability ([c371c8c](https://github.com/Excoriate/terraform-registry-aws-events/commit/c371c8ca6eeb9f229bb7d5cfc1da106747e97e2f))
* Add rotator specific configuration ([#15](https://github.com/Excoriate/terraform-registry-aws-events/issues/15)) ([2328f0c](https://github.com/Excoriate/terraform-registry-aws-events/commit/2328f0c24e16eee5c363f271bcf6473468d488bb))
* add schema attributes configuration ([e854694](https://github.com/Excoriate/terraform-registry-aws-events/commit/e854694b95291ed53968071f87d1058ba38da1bf))
* add ses event destionations ([aa93386](https://github.com/Excoriate/terraform-registry-aws-events/commit/aa93386a498d538bb485769f448400f32c2641a7))
* add sns module ([f55c372](https://github.com/Excoriate/terraform-registry-aws-events/commit/f55c372214b35c9b41fa87c9cdf3095f95dd910f))
* add software mfa token support ([f75db7a](https://github.com/Excoriate/terraform-registry-aws-events/commit/f75db7a3311fe26230e2da72baace85e6761b210))
* add sqs queue module ([79e740d](https://github.com/Excoriate/terraform-registry-aws-events/commit/79e740deb822bd5a6c13f769ee55eae4583334c8))
* add sqs queue module ([c780670](https://github.com/Excoriate/terraform-registry-aws-events/commit/c780670b439fc5ca04c27f80acb2c25aabff64ee))
* add support for password policy ([4921cce](https://github.com/Excoriate/terraform-registry-aws-events/commit/4921ccea56a8f73d400a1d45f13d1c59cf530790))
* add support for SMS ([a6335c6](https://github.com/Excoriate/terraform-registry-aws-events/commit/a6335c6703b71a95989024bc40255dca5c4d2433))
* add token validity units for user pool client ([4a98e8e](https://github.com/Excoriate/terraform-registry-aws-events/commit/4a98e8e834c3a0fe6452aaeaf436e7cbfca4a857))
* add user attribute update settings ([92e527f](https://github.com/Excoriate/terraform-registry-aws-events/commit/92e527f52afda10af9da06a831865c50863e0363))
* add user pool add ons configuration ([a25848c](https://github.com/Excoriate/terraform-registry-aws-events/commit/a25848cd61df5481070a707c1ad235a6e6e71bc5))
* add user pool client module ([8862df0](https://github.com/Excoriate/terraform-registry-aws-events/commit/8862df0ea64cdc35386b9cbe54cfc6b35b73e049))
* add user pool domain module ([cf23090](https://github.com/Excoriate/terraform-registry-aws-events/commit/cf23090748654556ffab3c433f842f70ba9227c3))
* add user-pool module ([991ce0c](https://github.com/Excoriate/terraform-registry-aws-events/commit/991ce0cf90099a6109ef5bb663e29c78d3d59aed))
* add verification capability ([e7b41a2](https://github.com/Excoriate/terraform-registry-aws-events/commit/e7b41a253eedfca4c2bb6072153527aef7525e65))
* add verification template capability ([6fc9ceb](https://github.com/Excoriate/terraform-registry-aws-events/commit/6fc9ceb48a506c9ce10c76a94c2b4416dc767061))
* Added feature_flags output to CloudWatch Metric Stream module ([#35](https://github.com/Excoriate/terraform-registry-aws-events/issues/35)) ([1eb10cd](https://github.com/Excoriate/terraform-registry-aws-events/commit/1eb10cda654f05abee03251101b7b3f2a8144e7a))
* Added new tests and dependencies ([#32](https://github.com/Excoriate/terraform-registry-aws-events/issues/32)) ([3d0b03d](https://github.com/Excoriate/terraform-registry-aws-events/commit/3d0b03d1e3ac817e3251534cd56d74070cec6f3a))
* **cloudwatch:** Add markdown table formatter for CloudWatch Metric Stream documentation ([#31](https://github.com/Excoriate/terraform-registry-aws-events/issues/31)) ([3490214](https://github.com/Excoriate/terraform-registry-aws-events/commit/3490214ac0275a7a1d7e6b8bde7d72983ddfcb15))
* Update IAM role name in main.tf ([#36](https://github.com/Excoriate/terraform-registry-aws-events/issues/36)) ([2a3cf93](https://github.com/Excoriate/terraform-registry-aws-events/commit/2a3cf93c94bd10ae0832ad3c4fa445a6fdf7af17))


### Bug Fixes

* add allowed prefix for cloudwatch log group ([fc74b19](https://github.com/Excoriate/terraform-registry-aws-events/commit/fc74b19d73ff185bfeb1030ab6f4afc6afa06e3f))
* Add missing putsecretvalue policy for rotation ([ad9e543](https://github.com/Excoriate/terraform-registry-aws-events/commit/ad9e54367738cf656d5d85c7afc121da5e25f0aa))
* fix conditional resource creation of lambda permissions for secrets manager ([858cba6](https://github.com/Excoriate/terraform-registry-aws-events/commit/858cba6d74a4dbe7bd81fa3084f5028414a5b929))
* Fix permissions in enabling optional secret manager invoke permissions ([1ff5662](https://github.com/Excoriate/terraform-registry-aws-events/commit/1ff56626ed232babab7c0e1697c3def5f4de4e30))
* remove inconsistent precondition ([e99e2a5](https://github.com/Excoriate/terraform-registry-aws-events/commit/e99e2a55758b11aedd0df8bcd2b3a0a520a49774))
* remove logs from suffix in cloudwatch loggroup naming ([#20](https://github.com/Excoriate/terraform-registry-aws-events/issues/20)) ([35edd3f](https://github.com/Excoriate/terraform-registry-aws-events/commit/35edd3fa0b12951f487b42ec7d01eb1ca87398a8))
* ses outputs ([9d24f5d](https://github.com/Excoriate/terraform-registry-aws-events/commit/9d24f5d003774531f743a264e36a1c7f6df95b12))


### Docs

* add missing outputs and updated documentation ([741ad7a](https://github.com/Excoriate/terraform-registry-aws-events/commit/741ad7a0f8814c9e6eb6b6f658835f085e454e00))


### Other

* **main:** release 0.1.1 ([#1](https://github.com/Excoriate/terraform-registry-aws-events/issues/1)) ([85a4bc9](https://github.com/Excoriate/terraform-registry-aws-events/commit/85a4bc98fd708129bb08043e100679bf7f72eff9))
* **main:** release 0.1.10 ([#19](https://github.com/Excoriate/terraform-registry-aws-events/issues/19)) ([b651e56](https://github.com/Excoriate/terraform-registry-aws-events/commit/b651e5637db7775d6f69ebbc0c285d957e70d8ce))
* **main:** release 0.1.11 ([#21](https://github.com/Excoriate/terraform-registry-aws-events/issues/21)) ([d3f4308](https://github.com/Excoriate/terraform-registry-aws-events/commit/d3f4308bd34885502315d3e014e681735c4dc87d))
* **main:** release 0.1.12 ([#22](https://github.com/Excoriate/terraform-registry-aws-events/issues/22)) ([5df56a8](https://github.com/Excoriate/terraform-registry-aws-events/commit/5df56a899e024f82c448c92084ebfad96c58ec66))
* **main:** release 0.1.13 ([#23](https://github.com/Excoriate/terraform-registry-aws-events/issues/23)) ([e98a663](https://github.com/Excoriate/terraform-registry-aws-events/commit/e98a66342f4dfaacbaae94ee83811254229bb8fb))
* **main:** release 0.1.14 ([#24](https://github.com/Excoriate/terraform-registry-aws-events/issues/24)) ([c2e56b5](https://github.com/Excoriate/terraform-registry-aws-events/commit/c2e56b5efe5bb737a6f5d5b500461e2fd17b1fed))
* **main:** release 0.1.15 ([#25](https://github.com/Excoriate/terraform-registry-aws-events/issues/25)) ([4c042c0](https://github.com/Excoriate/terraform-registry-aws-events/commit/4c042c0595c3814e5cfda032e66d417d767d640d))
* **main:** release 0.1.16 ([#26](https://github.com/Excoriate/terraform-registry-aws-events/issues/26)) ([e4c3d25](https://github.com/Excoriate/terraform-registry-aws-events/commit/e4c3d25a3a0f897b3cd41a6e200cf75f217eb51b))
* **main:** release 0.1.17 ([#27](https://github.com/Excoriate/terraform-registry-aws-events/issues/27)) ([5b640d3](https://github.com/Excoriate/terraform-registry-aws-events/commit/5b640d3c0dda01ca7e7d256aa0cffcdd5804a189))
* **main:** release 0.1.18 ([#28](https://github.com/Excoriate/terraform-registry-aws-events/issues/28)) ([b22d427](https://github.com/Excoriate/terraform-registry-aws-events/commit/b22d427e59f7eaf5bf991b571178e99fee7db671))
* **main:** release 0.1.2 ([#3](https://github.com/Excoriate/terraform-registry-aws-events/issues/3)) ([870b6a1](https://github.com/Excoriate/terraform-registry-aws-events/commit/870b6a1c30f8badd34b5b54da1ef0acb02f6fa9f))
* **main:** release 0.1.3 ([#5](https://github.com/Excoriate/terraform-registry-aws-events/issues/5)) ([cfa3d55](https://github.com/Excoriate/terraform-registry-aws-events/commit/cfa3d552fc9c1a1db5d77ef0ae6af4f884f4a045))
* **main:** release 0.1.4 ([#10](https://github.com/Excoriate/terraform-registry-aws-events/issues/10)) ([c3553a0](https://github.com/Excoriate/terraform-registry-aws-events/commit/c3553a0ff7c9545e218a2cd095ba7541519d5970))
* **main:** release 0.1.5 ([#13](https://github.com/Excoriate/terraform-registry-aws-events/issues/13)) ([fe8b8d9](https://github.com/Excoriate/terraform-registry-aws-events/commit/fe8b8d9a7d32b2247d742b93a5788e35051b3d71))
* **main:** release 0.1.6 ([#14](https://github.com/Excoriate/terraform-registry-aws-events/issues/14)) ([1be3401](https://github.com/Excoriate/terraform-registry-aws-events/commit/1be340167dcda40475d478ad130a9bab3f5db3e1))
* **main:** release 0.1.7 ([#16](https://github.com/Excoriate/terraform-registry-aws-events/issues/16)) ([31954c4](https://github.com/Excoriate/terraform-registry-aws-events/commit/31954c496c256ddf9111c34d87759d88d84bbf26))
* **main:** release 0.1.8 ([#17](https://github.com/Excoriate/terraform-registry-aws-events/issues/17)) ([3f2ac5c](https://github.com/Excoriate/terraform-registry-aws-events/commit/3f2ac5c9c8e69e2b7ef9d7b6233ef93b691cf411))
* **main:** release 0.1.9 ([#18](https://github.com/Excoriate/terraform-registry-aws-events/issues/18)) ([8e8b0fa](https://github.com/Excoriate/terraform-registry-aws-events/commit/8e8b0fa2b4f8357d90cb48c452d0fda1327fe240))
* remove comments ([c3fa23e](https://github.com/Excoriate/terraform-registry-aws-events/commit/c3fa23e1335f7fac99dc6b17d666e9ab17ec679e))


### Refactoring

* Add missing input variables in old recipes ([9f233e3](https://github.com/Excoriate/terraform-registry-aws-events/commit/9f233e33d8b7d1ce74f1fee9f9c4fc00b02a2adc))
* add ses missing output values ([0e054e2](https://github.com/Excoriate/terraform-registry-aws-events/commit/0e054e2e309e3c0d7fe290be28cdf08e302b2cd2))
* update latest version of template ([d22cf78](https://github.com/Excoriate/terraform-registry-aws-events/commit/d22cf78a767affd8c69537c5c03d13af53679777))
* upgrade terraform version ([53ceb61](https://github.com/Excoriate/terraform-registry-aws-events/commit/53ceb613d17368cf4ede2fd951560e5362a4c999))

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
