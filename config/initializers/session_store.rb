# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_photo_manager_session',
  :secret      => '16f0ce60fa025ef077236f7afeebe3991a63dc4d938e22ea30ec002a0fa51eee786e204e2730c5d046018c3a33c62f538e00c2c982624ae384ce1dc50360d57d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
