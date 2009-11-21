Factory.define :user do |u|
  u.login 'john'
  u.email 'john@example.com'
  u.password 'funkypass'
  u.password_confirmation 'funkypass'
end