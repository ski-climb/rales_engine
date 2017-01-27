## Rales Engine Project

### Description

Nick and Kyle's [Rales Engine](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/rails_engine.md) project for Turing. In this project we import business data and host an API with endpoints to return records, relationships between models, and business intelligence as JSON. Checkout the schema file `schema.png` in the public directory to see the models and their relationshps.

Tech stack: Ruby, Rails, PostgreSQL, RSpec

### Dependencies 

This project uses Ruby version 2.3+ with a PostgreSQL database. The dataset is from the [sales engine](https://github.com/turingschool-examples/sales_engine/tree/master/data) repository.

### Getting Started

Follow these steps in your terminal to clone the project on to your local machine and import the data.

  1. `cd` into the directory where you want the project in the terminal.
  1. Run `git clone https://github.com/ski-climb/rales_engine.git`
  1. `cd rales_engine` 
  1. `bundle` to install the gems you need
  1. `rake db:create` to create your PostgreSQL database
  1. `rake import:all` to import the data

### Test suite

Follow these steps in your terminal to run our test suite and check out the coverage.

  1. `rspec` to run the test suite
  1. `open coverage/index.html` to view the test coverage in your browser

### Hosting the site locally

  1. From within the `rales_engine` directory run `rails server` to start the server locally.
  1. In your browser visit any provided endpoint to view the response (example: `http://localhost:3000/api/v1/merchants`)
  1. Press `ctrl-c` to stop server.

### Running the Spec Harness

This project came with a spec harness. The spec harness checks the project's API endpoints by hitting urls on the local server. Follow these steps in your terminal to run the project agains the spec harness.

  1. From within the `rales_engine` directory run `rails server` to start the server locally.
  1. Open a new tab within your terminal. Be sure it is a new tab and the server is running in your first terminal tab.
  1. In your new terminal tab, run `git clone https://github.com/turingschool/rales_engine_spec_harness.git` 
  1. Run `bundle install` in the same terminal tab.
  1. In the same terminal tab, run `cd rales_engine_spec_harness`
  1. Still in the same terminal tab, run `rake` to run the spec harness tests.

### Endpoints Provided

The models are:
  * merchants
  * customers
  * items
  * invoices
  * invoice_items
  * transactions

In addition, Rails provides a way to view the existing routes (there are many in this project). To view all the available routes, use `/rails/info/routes`, e.g. `http://localhost:3000/rails/info/routes` on your local machine.

#### Single Finders

For any of the models visit :`GET /api/v1/models/find?parameters`

Parameters should that can be passed in are name, id, created_at, or updated_at. You can pass in multiple parameters.

For example: `GET /api/v1/merchants/find?name=Schroeder-Jerde`

Another example: `GET http://localhost:3000/api/v1/merchants/find?id=3`

#### Multi-Finders

For any of the models visit :`GET /api/v1/models/find_all?parameters`

Parameters should that can be passed in are name, id, created_at, or updated_at.

For example: `GET /api/v1/merchants/find_all?name=Cummings-Thiel`

Another example: `GET http://localhost:3000/api/v1/invoice_items/find_all?quantity=5&invoice_id=3`

#### Relationship Endpoints

##### Merchants

`GET /api/v1/merchants/:id/items` returns a collection of items associated with that merchant

`GET /api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders

##### Invoices

`GET /api/v1/invoices/:id/transactions` returns a collection of associated transactions

`GET /api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items

`GET /api/v1/invoices/:id/items` returns a collection of associated items

`GET /api/v1/invoices/:id/customer` returns the associated customer

`GET /api/v1/invoices/:id/merchant` returns the associated merchant

##### Invoice Items

`GET /api/v1/invoice_items/:id/invoice` returns the associated invoice

`GET /api/v1/invoice_items/:id/item`` returns the associated item

##### Items

`GET /api/v1/items/:id/invoice_items` returns a collection of associated invoice items

`GET /api/v1/items/:id/merchant` returns the associated merchant

##### Transactions

`GET /api/v1/transactions/:id/invoice` returns the associated invoice

##### Customers

`GET /api/v1/customers/:id/invoices` returns a collection of associated invoices

`GET /api/v1/customers/:id/transactions` returns a collection of associated transactions

#### Business Intelligence Endpoints

##### All Merchants

`GET /api/v1/merchants/most_revenue?quantity=x` returns the top x merchants ranked by total revenue

`GET /api/v1/merchants/most_items?quantity=x` returns the top x merchants ranked by total number of items sold

`GET /api/v1/merchants/revenue?date=x` returns the total revenue for date x across all merchants

##### Single Merchant

`GET /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across all transactions

`GET /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date x

`GET /api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions.

`GET /api/v1/merchants/:id/customers_with_pending_invoices` returns a collection of customers which have pending (unpaid) invoices.

##### Items

`GET /api/v1/items/most_revenue?quantity=x` returns the top x items ranked by total revenue generated

`GET /api/v1/items/most_items?quantity=x` returns the top x item instances ranked by total number sold

`GET /api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, returns the most recent day.

##### Customers

`GET /api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions
