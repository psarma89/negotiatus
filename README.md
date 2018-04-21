# README

This is a small app to track orders for Buyers and Vendors. There are two main routes. The index route will let you see reporting for pending deliveries. The new route allows you to create a new order to be tracked.
- /order/new
- /orders (index)

## Assumptions
1. No styling was required for the Assignment
2. Tests need to be written
3. Does not need to be deployed, localhost is ok

## Dependencies
1. PostgreSQL
2. Gems: See Gemfile

## Instructions
1. Git clone this repo
2. 'bundle install' to install gem dependencies
3. run 'rails load_db:create' rake task to seed development db
4. run 'rails s' to start rails server
5. Navigate to 'http://localhost:3000/orders' for dashboard

## To Do
- Make tests more robust
- Add a batch job to update order status
- Add map feature on index page
- Style Pages
