# Backend Engineer Challenge #

### Setup ###

Clone this repo and follows bellow.

#### Requirements

- Postgres
- Elixir with Phoenix
- ReactJS

#### Using docker
You could use docker compose to setup the entire environment

```sh
$ docker-compose build
$ docker-compose run --rm backend mix ecto.setup &&  mix run priv/repo/seeds.exs // Creates database and insert sample data
$ docker-compose up -d
```

#### Without docker
If you want to run it without docker, setup its pieces individually:

##### database
It uses a [postgres](https://www.postgresql.org/) database, follows the setup for your OS.

##### backend
The backend is made with elixir and phoenix framework. In order to properly setup an enviroment, run:
```sh
$ cd backend
$ mix deps.get
$ mix ecto.setup
$ mix run priv/repo/seeds.exs
$ mix phx.server
```

##### frontend
Frontend is made with react. To setup it, run:
```sh
$ cd frontend
$ npm install
$ npm run dev
```

### Getting started
Once you setup your environment, you'll be able to access it via [localhost:3000](http://localhost:3000), and access the API will be available at [localhost:4000](http://localhost:4000). You can interact with it through the react application or using the API directly.

### Documentation
Docs are available via ex_doc, run `mix docs` in project's root and it will be available via `doc/index.html`.

### Problem ###

We need to research about locales where consumer complains are made. That complains should have at least the attributes described bellow:

 - Title
 - Description
 - Locale
 - Company

Can you provide some services to ingest complains and get some data about its geolocation? For example, to find how many complains a specific company has in specific city?


### Recommendations ###
 - Use Restful instead Rest
 - Use microservice design if possible
 - Use a NoSql Database (if you use a database in your purpose)
 - We need to scale your services, decouple your modules if possible
 - Use devops mindset
 - Use Ruby or Elixir language and patterns

### Definition Of Done ###
 - A repository with read access to michel@reclameaqui.com.br, cleyton@trustvox.com.br, weslley@trustvox.com.br( feel free to choose your provider )
 - Documented, clean and testable/tested code
 - Documented strategy to deploy and run your code ( on cloud if possible )

### Questions? ###
 - Email me : cleyton@trustvox.com.br


