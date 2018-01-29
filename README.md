# IFSC Search

IFSC search is web interface for scrapping, filling up database and then searching on it using an HTML interface.

## Installation

You need to have the underlying technology installed that run the project

  * [Phoenix Framwork](https://hexdocs.pm/phoenix/installation.html#content)
  * [Postgres](https://www.postgresql.org/)
  * [LibreOffice(Optional)](https://www.libreoffice.org/)

## Clone this Repository

You'll want to clone this repository with git [clone] (https://github.com/vishaldeepak/ifsc_search.git). If you plan on contributing, you'll want to fork it.

enter the root project directory

```
cd ifsc_search
```

You can now fetch your dependencies, compile, and run the server:

```
mix deps.get

```

Create the database. Make sure you setup your development database name, username/password in `dev.exs`:
```
mix ecto.create && mix ecto.migrate
```

Install Node.js dependencies with
```
cd assets && npm install
```

You can now compile and run the server(from the project root directory):
```
mix phx.server
```
Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
## Setting Up

#### Scrape RBI Website
  In the root project directory hit the command. This should download all files in `build_data/IFSC_data`
  ```
   mix ifsc_scrapper
  ```
#### Convert .xls files to xlsx
  Some files downloaded will be in `xls` format. This project needs all files to be in `xlsx`.To do that I used libreOffice command line tool.
  ```
  cd build_data/IFSC_data
  soffice --headless --convert-to xlsx *.xls
  ```

#### Run tasks to build database
  Now process these files to build data to database. Make sure to go back to the root project directory.`cd ../..`
  ```
  # Add States
  mix parse_states

  # Add Banks and Branches
  mix parse_ifsc
  ```