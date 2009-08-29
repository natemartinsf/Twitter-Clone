# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twitter-clone_session',
  :secret      => 'eb02c84524a3d1eeff6ce57d5cfb6290d78dce62bedc98f1e3ece1ce12694c0d2da81e7cdb19b18c727b3f28323dc8b18e6c38df451acb516294e51da9cc5940'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
