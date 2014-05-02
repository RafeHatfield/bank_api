Bank Api
=========

 * for speed this is being built as a full stack rails app, in practice this would have been built using rails-api
 * minimal requirements show no indication of needing multiple accounts per user or card, so not implemented
 * pin shouldn't be stored as straight text
 * balance being stored as cents for simplicity, with conversion method to dollars
 * not checking if api_key is unique for simplicity
 * no mention made of valid amounts for withdrawals, so random amounts allowed (cents amounts etc)
