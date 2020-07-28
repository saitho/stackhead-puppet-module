## [1.7.12](https://github.com/getstackhead/puppet-module/compare/v1.7.11...v1.7.12) (2020-07-28)


### Bug Fixes

* adjust require ([d3bd870](https://github.com/getstackhead/puppet-module/commit/d3bd8704a5f575cf50bdd209cc9f2cdeff6cf1a5))

## [1.7.11](https://github.com/getstackhead/puppet-module/compare/v1.7.10...v1.7.11) (2020-07-28)


### Bug Fixes

* remove invalid require ([69d9744](https://github.com/getstackhead/puppet-module/commit/69d97443c475cc4ff4492e0789e8abb95ae7a6e6))

## [1.7.10](https://github.com/getstackhead/puppet-module/compare/v1.7.9...v1.7.10) (2020-07-28)


### Bug Fixes

* try setting execution order ([f562206](https://github.com/getstackhead/puppet-module/commit/f56220651fad3223685e59d4a95eb45eb15376f7))

## [1.7.9](https://github.com/getstackhead/puppet-module/compare/v1.7.8...v1.7.9) (2020-07-28)


### Bug Fixes

* **nginx:** enable ssl in server configuration ([e8a82fb](https://github.com/getstackhead/puppet-module/commit/e8a82fb61ef17af26943056a45102dc8a8268d4b))

## [1.7.8](https://github.com/getstackhead/puppet-module/compare/v1.7.7...v1.7.8) (2020-07-28)


### Bug Fixes

* **nginx:** fix ssl settings ([7751a22](https://github.com/getstackhead/puppet-module/commit/7751a22cadb510bd8a26531545d6ded60dd97330))

## [1.7.7](https://github.com/getstackhead/puppet-module/compare/v1.7.6...v1.7.7) (2020-07-28)


### Bug Fixes

* **nginx:** adjust container location definition ([a9ca35e](https://github.com/getstackhead/puppet-module/commit/a9ca35e38144d6a3203e5e55a94e75223947771f))

## [1.7.6](https://github.com/getstackhead/puppet-module/compare/v1.7.5...v1.7.6) (2020-07-28)


### Bug Fixes

* **nginx:** adjust container location name ([eda4820](https://github.com/getstackhead/puppet-module/commit/eda4820be4eaebeb2d52616134e45154b10d2e7d))

## [1.7.5](https://github.com/getstackhead/puppet-module/compare/v1.7.4...v1.7.5) (2020-07-28)


### Bug Fixes

* **nginx/basicauth:** add basic auth only to Docker proxy ([5c52e1f](https://github.com/getstackhead/puppet-module/commit/5c52e1f5798247d81dbd0e76bfeb18dc07975b4e))

## [1.7.4](https://github.com/getstackhead/puppet-module/compare/v1.7.3...v1.7.4) (2020-07-28)


### Bug Fixes

* **nginx/ssl:** path to real certificates ([883ff4c](https://github.com/getstackhead/puppet-module/commit/883ff4c74247c9fe9302260aa4f0bf427d1da0cb))

## [1.7.3](https://github.com/getstackhead/puppet-module/compare/v1.7.2...v1.7.3) (2020-07-28)


### Bug Fixes

* **nginx/basicauth:** htaccess and certificate paths ([a8ec984](https://github.com/getstackhead/puppet-module/commit/a8ec984d85e65bab088a3ddad54030ec42ada997))

## [1.7.2](https://github.com/getstackhead/puppet-module/compare/v1.7.1...v1.7.2) (2020-07-28)


### Bug Fixes

* **nginx/basicauth:** illegal array access ([ae2c277](https://github.com/getstackhead/puppet-module/commit/ae2c2777677770599376448d3da897efbd0aa997))

## [1.7.1](https://github.com/getstackhead/puppet-module/compare/v1.7.0...v1.7.1) (2020-07-28)


### Bug Fixes

* basic auth file definition ([9d2d2be](https://github.com/getstackhead/puppet-module/commit/9d2d2be1fe28d93a6adb54082d14d1fb7473cd45))

# [1.7.0](https://github.com/getstackhead/puppet-module/compare/v1.6.0...v1.7.0) (2020-07-28)


### Features

* create basic auth file ([c1fefab](https://github.com/getstackhead/puppet-module/commit/c1fefab34656a9ea2f35ac1f51f0a169d289dbe3))
* updates symlink after certificates have been created ([0cb3726](https://github.com/getstackhead/puppet-module/commit/0cb3726b3a8ce2076e072ae438c5fccfecd0ea1b))

# [1.6.0](https://github.com/getstackhead/puppet-module/compare/v1.5.2...v1.6.0) (2020-07-28)


### Features

* add test setting ([dc4cba9](https://github.com/getstackhead/puppet-module/commit/dc4cba9a3689090886828345460139c47d8fcbdb))

## [1.5.2](https://github.com/getstackhead/puppet-module/compare/v1.5.1...v1.5.2) (2020-07-28)


### Bug Fixes

* **nginx/cert:** adjust acme challenge path ([9bb9b70](https://github.com/getstackhead/puppet-module/commit/9bb9b7037e4706bbb531acfb3d833f315bf214fb))

## [1.5.1](https://github.com/getstackhead/puppet-module/compare/v1.5.0...v1.5.1) (2020-07-27)


### Bug Fixes

* **nginx:** syntax error ([a1469de](https://github.com/getstackhead/puppet-module/commit/a1469de2495bd55649352e7da5bd6bcc4bcde85e))

# [1.5.0](https://github.com/getstackhead/puppet-module/compare/v1.4.1...v1.5.0) (2020-07-27)


### Features

* **nginx:** add basic auth ([ea31f37](https://github.com/getstackhead/puppet-module/commit/ea31f37b6b6e338aca171d0fb9621c2200ff0d4f))

## [1.4.1](https://github.com/getstackhead/puppet-module/compare/v1.4.0...v1.4.1) (2020-07-27)


### Bug Fixes

* **nginx:** include additional ssl file if it exists ([c4f78df](https://github.com/getstackhead/puppet-module/commit/c4f78dff534944454bd02cbcede287f5e7da9f6b))
* **nginx:** remove additional include as settings already present ([6584464](https://github.com/getstackhead/puppet-module/commit/65844645d401ff5415de762ea46a10888974f0a8))

# [1.4.0](https://github.com/getstackhead/puppet-module/compare/v1.3.1...v1.4.0) (2020-07-27)


### Bug Fixes

* fix acme dirs ([c46e158](https://github.com/getstackhead/puppet-module/commit/c46e158a7fc73b3bedf5a213fdb54e45bf9b37d8))


### Features

* **nginx:** additional ssl settings ([d730b89](https://github.com/getstackhead/puppet-module/commit/d730b89bd06251a8d41340eef3dcb795d2fac234))

## [1.3.1](https://github.com/getstackhead/puppet-module/compare/v1.3.0...v1.3.1) (2020-07-27)


### Bug Fixes

* variable override ([8eb6d46](https://github.com/getstackhead/puppet-module/commit/8eb6d46b36e0a4c62862457d164aaa2cb947a92f))

# [1.3.0](https://github.com/getstackhead/puppet-module/compare/v1.2.10...v1.3.0) (2020-07-27)


### Features

* add project_name setting ([f7b6c60](https://github.com/getstackhead/puppet-module/commit/f7b6c60ebdb6e3c497bb5056c7691c6e77b1324f))
* introduce ensure setting ([a27cecb](https://github.com/getstackhead/puppet-module/commit/a27cecb78093f25b4a66d8ee67c3d0877def98a8))

## [1.2.10](https://github.com/getstackhead/puppet-module/compare/v1.2.9...v1.2.10) (2020-07-27)


### Bug Fixes

* drop $iteration_counter for $name ([0da52b9](https://github.com/getstackhead/puppet-module/commit/0da52b960cdf123c21332ef894ac03ce93af2e8e))

## [1.2.9](https://github.com/getstackhead/puppet-module/compare/v1.2.8...v1.2.9) (2020-07-27)


### Bug Fixes

* replace $ssl_counter with $iteration_counter ([a797874](https://github.com/getstackhead/puppet-module/commit/a797874c46569656d0f9796f3ecc73e3901ef943))

## [1.2.8](https://github.com/getstackhead/puppet-module/compare/v1.2.7...v1.2.8) (2020-07-27)


### Bug Fixes

* fix operators ([e2c5813](https://github.com/getstackhead/puppet-module/commit/e2c5813f65d56220a17cedae9f79d277a2a05374))

## [1.2.7](https://github.com/getstackhead/puppet-module/compare/v1.2.6...v1.2.7) (2020-07-27)


### Bug Fixes

* set counter on fake cert execs to avoid duplicate error ([de9bb9c](https://github.com/getstackhead/puppet-module/commit/de9bb9c1ee2686893acb997594d366cb87ce2ce8))

## [1.2.6](https://github.com/getstackhead/puppet-module/compare/v1.2.5...v1.2.6) (2020-07-27)


### Bug Fixes

* try different exec configuration ([3ed61b0](https://github.com/getstackhead/puppet-module/commit/3ed61b015f6868b67ffd218a9e8f6cc8beceb293))

## [1.2.5](https://github.com/getstackhead/puppet-module/compare/v1.2.4...v1.2.5) (2020-07-27)


### Bug Fixes

* add project name to fake cert execs ([6499b9c](https://github.com/getstackhead/puppet-module/commit/6499b9c96e6f9571927bdbdb1d7c915ddfaa9efb))
* **nginx:** default certificate symlinks ([9bf936a](https://github.com/getstackhead/puppet-module/commit/9bf936a8a4ea915c11cfc7e5a849ed9bc11aa265))



## [1.2.4](https://github.com/getstackhead/puppet-module/compare/v1.2.3...v1.2.4) (2020-07-27)


### Bug Fixes

* **nginx:** acme location alias ([49b8566](https://github.com/getstackhead/puppet-module/commit/49b856629f79fe250d393c089d3ae4445d303cf0))



## [1.2.3](https://github.com/getstackhead/puppet-module/compare/v1.2.2...v1.2.3) (2020-07-27)


### Bug Fixes

* **nginx:** move acme location config back ([66d2035](https://github.com/getstackhead/puppet-module/commit/66d203516f6fb8c53aaeb7a8fa9ab41b4d4b5222))



## [1.2.2](https://github.com/getstackhead/puppet-module/compare/v1.2.1...v1.2.2) (2020-07-27)


### Bug Fixes

* certificate handling ([1a0b651](https://github.com/getstackhead/puppet-module/commit/1a0b6511af3eced212ad44625734b08cfb4d10ef))



## [1.2.1](https://github.com/getstackhead/puppet-module/compare/v1.2.0...v1.2.1) (2020-07-27)


### Bug Fixes

* missing variable symbol ([5d89182](https://github.com/getstackhead/puppet-module/commit/5d8918222139d31b62091f76d80d612ddbb1a057))



# [1.2.0](https://github.com/getstackhead/puppet-module/compare/v1.1.1...v1.2.0) (2020-07-27)


### Features

* class settings ([87fbcfc](https://github.com/getstackhead/puppet-module/commit/87fbcfc0cf3ea2fadb7403bcffc5ab4247df7063))
* ssl certificates in nginx configuration ([1d321b5](https://github.com/getstackhead/puppet-module/commit/1d321b559062f88d307c489dbc9bfdbc5bd90eda))
* WIP class for setting up a container project ([58d3be7](https://github.com/getstackhead/puppet-module/commit/58d3be7b7e85e2558abeff2a1017954f9d5d1cda))



## [1.1.1](https://github.com/getstackhead/puppet-module/compare/v1.1.0...v1.1.1) (2020-07-24)


### Bug Fixes

* **nginx/ssl_proxy:** server_name syntax ([dc9c892](https://github.com/getstackhead/puppet-module/commit/dc9c89208090170460f0118b204fe5e8b2900764))



# [1.1.0](https://github.com/getstackhead/puppet-module/compare/v1.0.0...v1.1.0) (2020-07-24)


### Features

* **nginx/ssl_proxy:** add server_name option ([6b0467d](https://github.com/getstackhead/puppet-module/commit/6b0467d37306bb616ee4937a9d03b22004758df4))
* **nginx/ssl_proxy:** add ssl_cert and ssl_key option ([202e26f](https://github.com/getstackhead/puppet-module/commit/202e26f3a1e80019418caddd579ef68e90dfb813))



# 1.0.0 (2020-07-24)


### Features

* add base structure ([c9cf373](https://github.com/getstackhead/puppet-module/commit/c9cf3733044dd4dfa29e1476d8054429ca3e3e6e))
* add nginx proxy class ([9f78aba](https://github.com/getstackhead/puppet-module/commit/9f78aba134c6d57484475a02632816f4b31ca8ce))
