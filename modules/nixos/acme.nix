# Enable the ACME client.
{ config, ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = config.salad.users.main.email;
    };
  };
}
