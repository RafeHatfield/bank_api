Bank Api
=========

Assumptions and Notes

 * for speed this is being built as a full stack rails app, in practice this would have been built using rails-api
 * minimal requirements show no indication of needing multiple accounts per user or card, so not implemented
 * pin shouldn't be stored as straight text
 * balance being stored as cents for simplicity, with conversion method to dollars
 * not checking if api_key is unique for simplicity
 * no mention made of valid amounts for withdrawals, so random amounts allowed
 * all amounts are converted to integers, no cents allowed
 * token should probably be reset after each authentication, not done for simplicity
 * logging is at 2 levels; there is an events model for transaction logging in the db, and entries are also written to Rails.logger

To run test suite

 * rake db:create
 * rake db:migrate
 * rake db:test:prepare
 * rspec spec

To run the app

 * rake db:create
 * rake db:migrate
 * rails s

Routes have been set up to have a versioned api, URL's of the format:

http://mydomainhere.com/v1/action_name

Requests are defaulted to json, and the api namespacing exists but has been removed from the URL.
