# Monte Cinema

Rubycamp project.

Tech Stack:

* Ruby: 3.1.2

* Rails 7.0.3

* PostgerSQL 14.5

* Sidekiq 6.5

# Installation

```
# Clone repository:
$ git clone https://github.com/MonikaLukowska/monte-cinema

# Install gems:
$ bundle install

# Create database and seeds:
$ rails db:create
$ rails db:migrate
$ rails db:seed

# Run server
$ rails server

# Run Sidekiq
$ bundle exec sidekiq
```

# Features/functionalities

&rarr; Login and registration
&rarr; Authorization for differnt roles
&rarr; Internal booking system
&rarr; Api for communication with automated devices (at the moment only 2 endpoints - index for movies by seances dates and show seance)
&rarr; External/public reservation system
&rarr; Automatic cancellation
&rarr; Mailers

# Live
[heroku app](https://monka-monte-cinema.herokuapp.com/)

Credential for test manager:

**e-mail:** manager@example.com
**password:** password

Credential for test client:

**e-mail:** client1@example.com
**password:** password

# API documentation
[link](https://monka-monte-cinema.herokuapp.com/api-docs/index.html)
